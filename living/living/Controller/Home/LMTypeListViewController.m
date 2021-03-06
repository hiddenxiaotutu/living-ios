//
//  LMTypeListViewController.m
//  living
//
//  Created by Ding on 2016/12/8.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMTypeListViewController.h"
#import "LMArtcleTypeRequest.h"
#import "FitNavigationController.h"

@interface LMTypeListViewController ()

@end

@implementation LMTypeListViewController
{
    
    NSArray * typeList;
    
}
+ (void)presentInViewController:(UIViewController *)viewController Animated:(BOOL)animated
{
    if (!viewController) {
        return;
    }
    
    LMTypeListViewController      *loginVC    = [[LMTypeListViewController alloc] init];
    FitNavigationController *navVC      = [[FitNavigationController alloc] initWithRootViewController:loginVC];
    
    [viewController presentViewController:navVC animated:animated completion:^{
        
    }];
}

- (id)init
{
    self = [super init];
    if (self) {
        typeList = @[@"美丽", @"健康", @"美食", @"幸福"];
        self.hidesBottomBarWhenPushed   = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    //[self loadNewer];
    self.navigationItem.title = self.name;
}

- (void)createUI
{
    [super createUI];
    self.tableView.contentInset                 = UIEdgeInsetsMake(64, 0, 0, 0);
    self.pullToRefreshView.defaultContentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets        = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.separatorInset               = UIEdgeInsetsMake(0, 15, 0, 0);
}

//- (FitBaseRequest *)request
//{
//    LMArtcleTypeRequest *request = [[LMArtcleTypeRequest alloc] init];
//    
//    return request;
//}
//
//- (NSArray *)parseResponse:(NSString *)resp
//{
//    NSDictionary    *bodyDic    = [VOUtil parseBody:resp];
//    
//    NSString        *result     = [bodyDic objectForKey:@"result"];
//    
//    if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSString class]] && [result isEqualToString:@"0"]) {
//        
//        self.max    = [[bodyDic objectForKey:@"total"] intValue];
//        
//        NSArray *resultArr      = [bodyDic objectForKey:@"list"];
//        
//        if (resultArr && resultArr.count > 0) {
//            
//            return resultArr;
//        }
//    }
//    
//    return nil;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdd = @"cellIdd";
    UITableViewCell *cell   = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (cell) {
        
        return cell;
    }
    
    cell    = [tableView dequeueReusableCellWithIdentifier:cellIdd];
    
    if (!cell) {
        
        cell    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdd];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = typeList[indexPath.row];
    cell.textLabel.font         = TEXT_FONT_LEVEL_2;
    cell.textLabel.textColor    = TEXT_COLOR_LEVEL_2;
//    if (self.listData.count > indexPath.row) {
//        
//        NSDictionary *dic = self.listData[indexPath.row];
//        
//        if ([dic objectForKey:@"type"] && ![[dic objectForKey:@"type"] isEqual:[NSNull null]]
//            && [[dic objectForKey:@"type"] isKindOfClass:[NSString class]]) {
//            
//            cell.textLabel.text = dic[@"type"];
//            
//        } else {
//            
//            cell.textLabel.text = @"";
//        }
//        
//        cell.textLabel.font         = TEXT_FONT_LEVEL_2;
//        cell.textLabel.textColor    = TEXT_COLOR_LEVEL_2;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.listData.count > indexPath.row) {
//        
//        NSDictionary *dic = self.listData[indexPath.row];
//    
//        if ([dic objectForKey:@"type"] && ![[dic objectForKey:@"type"] isEqual:[NSNull null]]
//            && [[dic objectForKey:@"type"] isKindOfClass:[NSString class]]) {
    
            [self.delegate backLiveName:typeList[indexPath.row]];
//        }
//    
        [self.navigationController popViewControllerAnimated:YES];
//    }
}

@end
