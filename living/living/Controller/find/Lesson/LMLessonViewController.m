//
//  LMLessonViewController.m
//  living
//
//  Created by Ding on 2016/12/5.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMLessonViewController.h"
#import "LMClassroomDetailViewController.h"
#import "LMLivingRoomRequest.h"
#import "LMClassroomCell.h"
#import "ClassroomVO.h"
#import "LMChatViewController.h"

@interface LMLessonViewController ()

@end

@implementation LMLessonViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        self.ifRemoveLoadNoState        = NO;
        self.ifShowTableSeparator       = NO;
        self.hidesBottomBarWhenPushed   = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNoState) name:@"reload" object:nil];
    }
    
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.listData.count == 0) {
    
        [self loadNoState];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenAction" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语音课堂";
    [self creatUI];
    [self loadNewer];
}

- (void)creatUI
{
    [super createUI];
    self.tableView.frame = CGRectMake(0, -60, kScreenWidth, kScreenHeight-54);
    
    self.tableView.keyboardDismissMode          = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.contentInset                 = UIEdgeInsetsMake(64, 0, 0, 0);
    self.pullToRefreshView.defaultContentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets        = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    [self createFooterView];
}

- (void)createFooterView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    self.tableView.tableFooterView = footView;
}

- (FitBaseRequest *)request
{
    LMLivingRoomRequest    *request    = [[LMLivingRoomRequest alloc] initWithPageIndex:self.current andPageSize:20];
    
    return request;
}

- (NSArray *)parseResponse:(NSString *)resp
{
    NSDictionary *bodyDic = [VOUtil parseBody:resp];
    
    NSData *respData = [resp dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSDictionary *respDict = [NSJSONSerialization
                              JSONObjectWithData:respData
                              options:NSJSONReadingMutableLeaves
                              error:nil];
    
    NSDictionary *headDic = [respDict objectForKey:@"head"];
    
    NSString    *coderesult         = [headDic objectForKey:@"returnCode"];
    
    if (coderesult && ![coderesult isEqual:[NSNull null]] && [coderesult isKindOfClass:[NSString class]] && [coderesult isEqualToString:@"000"]) {
        
        if (headDic[@"prove"]&&![headDic[@"prove"] isEqual:@""]) {
            if ([headDic[@"prove"] isEqualToString:@"teacher"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ifCanpublic" object:nil];
                });
               
            }    
        }

    }
    
    NSString    *result         = [bodyDic objectForKey:@"result"];
    NSString    *description    = [bodyDic objectForKey:@"description"];
    
    if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSString class]] && [result isEqualToString:@"0"]) {
        
        self.max    = [[bodyDic objectForKey:@"total"] intValue];
        
        NSArray *resultArr = [ClassroomVO ClassroomVOListWithArray:[bodyDic objectForKey:@"list"]];
        
        NSLog(@"******************%@",resultArr);
        
        if (resultArr&&resultArr.count>0) {
           return resultArr;
        }
        
    } else if (description && ![description isEqual:[NSNull null]] && [description isKindOfClass:[NSString class]]) {
        
        [self performSelectorOnMainThread:@selector(textStateHUD:) withObject:description waitUntilDone:NO];
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h   = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if (h) {
        
        return h;
    }
    
    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell   = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (cell) {
        
        return cell;
    }
    
    cell    = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell    = [[LMClassroomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (self.listData.count > indexPath.row) {
        ClassroomVO *vo = self.listData[indexPath.row];     
            if (vo && [vo isKindOfClass:[ClassroomVO class]]) {
                
                [(LMClassroomCell *)cell setValue:vo];
            }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listData.count>indexPath.row) {
        ClassroomVO *vo = self.listData[indexPath.row];
        if ([vo.status isEqual:@"open"]) {
            
            if (vo.role&&([vo.role isEqualToString:@"host"]||[vo.role isEqualToString:@"teacher"])) {
                LMChatViewController *roomVC = [[LMChatViewController alloc] init];
                [roomVC setHidesBottomBarWhenPushed:YES];
                roomVC.voiceUuid = vo.voiceUuid;
                roomVC.sign = vo.sign;
                roomVC.roles = vo.role;
                [self.navigationController pushViewController:roomVC animated:YES];
            }
            if (vo.role&&[vo.role isEqualToString:@"student"]&&vo.isBuy==YES) {
                LMChatViewController *roomVC = [[LMChatViewController alloc] init];
                [roomVC setHidesBottomBarWhenPushed:YES];
                roomVC.voiceUuid = vo.voiceUuid;
                roomVC.sign = vo.sign;
                roomVC.roles = vo.role;
                [self.navigationController pushViewController:roomVC animated:YES];
            }
            
            if (vo.role&&[vo.role isEqualToString:@"student"]&&vo.isBuy==NO) {
                LMClassroomDetailViewController *voiceVC = [[LMClassroomDetailViewController alloc] init];
                voiceVC.voiceUUid = vo.voiceUuid;
                voiceVC.role = vo.role;
                [voiceVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:voiceVC animated:YES];
            }
            
        }else{
            LMClassroomDetailViewController *voiceVC = [[LMClassroomDetailViewController alloc] init];
            voiceVC.voiceUUid = vo.voiceUuid;
            voiceVC.role = vo.role;
            [voiceVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:voiceVC animated:YES];
            
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenAction" object:nil];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenAction" object:nil];
}


@end
