//
//  LMActivityDetailController.m
//  living
//
//  Created by Ding on 16/9/30.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMActivityDetailController.h"
#import "LMCommentCell.h"
#import "UIView+frame.h"
#import "LMActivityheadCell.h"
#import "LMActivityMsgCell.h"

@interface LMActivityDetailController ()<UITableViewDelegate,
UITableViewDataSource,
UITextViewDelegate,
UITextViewDelegate,
LMActivityheadCellDelegate
>
{
    UITableView *_tableView;
    UILabel  *tipLabel;
    UIButton *zanButton;
    UITextView *suggestTF;
    UIView *headerView;
    
}


@end

@implementation LMActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    [self getHomeDataRequest];

    
}

-(void)creatUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.keyboardDismissMode          = UIScrollViewKeyboardDismissModeOnDrag;
    
    headerView = [UIView new];
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    headerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    headerView.hidden=YES;
    [self.view addSubview:headerView];
    
    
}
-(void)creatHeaderView
{

    
    
    //活动人头像
    UIImageView *headV = [UIImageView new];
    headV.backgroundColor = [UIColor blueColor];
    headV.layer.cornerRadius = 5.f;
    [headV sizeToFit];
    headV.frame = CGRectMake(15, 30, 40, 40);
    [headerView addSubview:headV];
    
    //活动人名
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"发布者：高琛";
    nameLabel.font = [UIFont systemFontOfSize:13.f];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel sizeToFit];
       nameLabel.frame = CGRectMake(60, 30, nameLabel.bounds.size.width, nameLabel.bounds.size.height);
    [headerView addSubview:nameLabel];
    
    //费用
    UILabel *countLabel = [UILabel new];
    countLabel.text = @"活动人数：1000/10人";
    countLabel.textColor = [UIColor whiteColor];
    countLabel.font = [UIFont systemFontOfSize:13.f];
    [countLabel sizeToFit];
    countLabel.frame = CGRectMake(60, 35+nameLabel.bounds.size.height, countLabel.bounds.size.width, countLabel.bounds.size.height);
    [headerView addSubview:countLabel];
    
    
    UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //        _topBtn.backgroundColor = _COLOR_N(red);
    [joinButton setTitle:@"报名" forState:UIControlStateNormal];
    [joinButton setTintColor:[UIColor whiteColor]];
    joinButton.showsTouchWhenHighlighted = YES;
    joinButton.frame = CGRectMake(kScreenWidth-70, 25, 60.f, 50.f);
    [joinButton addTarget:self action:@selector(cellWillApply:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:joinButton];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor whiteColor];
    [line sizeToFit];
    line.frame = CGRectMake(kScreenWidth-71, 35, 1, 30);
    [headerView addSubview:line];
    
    

    
    
  

    
    
}





-(void)getHomeDataRequest
{
    [self creatHeaderView];
    
}

-(void)getHomeDataResponse:(NSString *)resp
{
    NSDictionary *bodyDic = [VOUtil parseBody:resp];
    
    if ([[bodyDic objectForKey:@"result"] isEqual:@"0"]) {
        NSLog(@"%@",bodyDic);
        
        
        
        [_tableView reloadData];
    }else{
        NSString *str = [bodyDic objectForKey:@"description"];
        [self textStateHUD:str];
    }
    
    
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 230;
    }
    if (indexPath.section==1) {
        return 155;
    }
    
    if (indexPath.section==2) {
        
            NSString *string = @"这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题";
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
            CGFloat conHigh = [string boundingRectWithSize:CGSizeMake(kScreenWidth-30, 100000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
            
            NSString *string2 = @"这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文";
            NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
            CGFloat conHigh2 = [string2 boundingRectWithSize:CGSizeMake(kScreenWidth-30, 100000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes2 context:nil].size.height;
            
            
            return 270+conHigh+conHigh2;
        
    }
    if (indexPath.section==3) {
        return [LMCommentCell cellHigth:@"果然我问问我吩咐我跟我玩嗡嗡图文无关的身份和她和热稳定"];
    }
    
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{


    if (section==1){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 35)];
        commentView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:commentView];
        
        UILabel *commentLabel = [UILabel new];
        commentLabel.font = [UIFont systemFontOfSize:13.f];
        
        commentLabel.textColor = TEXT_COLOR_LEVEL_2;
        commentLabel.text = @"活动信息";
        [commentLabel sizeToFit];
        commentLabel.frame = CGRectMake(15, 10, commentLabel.bounds.size.width, commentLabel.bounds.size.height);
        [commentView addSubview:commentLabel];
        
        
        UIView *line = [UIView new];
        line.backgroundColor =[UIColor colorWithRed:0/255.0 green:130/255.0 blue:230.0/255.0 alpha:1.0];
        [line sizeToFit];
        line.frame =CGRectMake(0, 10+1, 3.f, commentLabel.bounds.size.height-2);
        [commentView addSubview:line];
        
        headView.backgroundColor = [UIColor clearColor];
        
        
        return headView;
    }
    if (section==2){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 35)];
        commentView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:commentView];
        
        UILabel *commentLabel = [UILabel new];
        commentLabel.font = [UIFont systemFontOfSize:13.f];
        
        commentLabel.textColor = TEXT_COLOR_LEVEL_2;
        commentLabel.text = @"活动介绍";
        [commentLabel sizeToFit];
        commentLabel.frame = CGRectMake(15, 10, commentLabel.bounds.size.width, commentLabel.bounds.size.height);
        [commentView addSubview:commentLabel];
        
        
        UIView *line = [UIView new];
        line.backgroundColor =[UIColor colorWithRed:0/255.0 green:130/255.0 blue:230.0/255.0 alpha:1.0];
        [line sizeToFit];
        line.frame =CGRectMake(0, 10+1, 3.f, commentLabel.bounds.size.height-2);
        [commentView addSubview:line];
        
        headView.backgroundColor = [UIColor clearColor];
        
        
        return headView;
    }


    
    
    if (section==3){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
        
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 155)];
        commentView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:commentView];
        
        UILabel *commentLabel = [UILabel new];
        commentLabel.font = [UIFont systemFontOfSize:13.f];
        
        commentLabel.textColor = TEXT_COLOR_LEVEL_2;
        commentLabel.text = @"留言列表";
        suggestTF = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30, 100)];
        suggestTF.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        suggestTF.layer.cornerRadius=5;
        suggestTF.textColor = TEXT_COLOR_LEVEL_3;
        suggestTF.font = TEXT_FONT_LEVEL_3;
        suggestTF.layer.borderColor = LINE_COLOR.CGColor;
        suggestTF.layer.borderWidth = 0.5;
        suggestTF.delegate = self;
        [commentView addSubview:suggestTF];
        
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-50, 20)];
        tipLabel.text = @"给点留言或建议...";
        tipLabel.textColor = TEXT_COLOR_LEVEL_3;
        tipLabel.font = TEXT_FONT_LEVEL_3;
        [suggestTF addSubview:tipLabel];
        
        UIButton *besureButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [besureButton setTitle:@"确认" forState:UIControlStateNormal];
        [besureButton setTintColor:LIVING_COLOR];
        besureButton.layer.cornerRadius = 3;
        besureButton.layer.borderWidth = 0.5;
        besureButton.layer.borderColor = LIVING_COLOR.CGColor;
        besureButton.showsTouchWhenHighlighted = YES;
        besureButton.frame = CGRectMake(kScreenWidth-85, 70, 50.f, 25.f);
        [besureButton addTarget:self action:@selector(besureAction:) forControlEvents:UIControlEventTouchUpInside];
        [suggestTF addSubview:besureButton];
        
        
        [commentLabel sizeToFit];
        commentLabel.frame = CGRectMake(15, 120, commentLabel.bounds.size.width, commentLabel.bounds.size.height);
        [commentView addSubview:commentLabel];
        
        
        UIView *line = [UIView new];
        line.backgroundColor =[UIColor colorWithRed:0/255.0 green:130/255.0 blue:230.0/255.0 alpha:1.0];
        [line sizeToFit];
        line.frame =CGRectMake(0, 120+1, 3.f, commentLabel.bounds.size.height-2);
        [commentView addSubview:line];
        
        headView.backgroundColor = [UIColor clearColor];
        
        
        return headView;
        
        
        
        
    }
    
    
    
    return nil;
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 40;
    }
    if (section==2) {
        return 40;
    }
    if (section==3) {
        return 150;
    }

    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 7;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section==0) {
        static NSString *cellId = @"cellIdd";
        LMActivityheadCell *cell = [[LMActivityheadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setXScale:self.xScale yScale:self.yScaleNoTab];
        cell.delegate = self;
        return cell;
            
        }
    
    if (indexPath.section==1) {
        static NSString *cellId = @"cellIddd";
        LMActivityMsgCell *cell = [[LMActivityMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setXScale:self.xScale yScale:self.yScaleNoTab];
        
        return cell;
        
    }
    
        if (indexPath.section==2) {
            static NSString *cellId = @"cellId";
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *dspLabel = [UILabel new];
            dspLabel.font = TEXT_FONT_LEVEL_2;
            dspLabel.textColor = TEXT_COLOR_LEVEL_2;
            dspLabel.numberOfLines=0;
            dspLabel.text = @"这这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题这是标题";
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
            CGFloat conHigh = [dspLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth-30, 100000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
            [dspLabel sizeToFit];
            dspLabel.frame = CGRectMake(15, 10, kScreenWidth-30, conHigh);
            [cell.contentView addSubview:dspLabel];
            
            UIImageView *headImage = [UIImageView new];
            headImage.image = [UIImage imageNamed:@"112"];
            headImage.frame = CGRectMake(15, 20+conHigh, kScreenWidth-30, 210);
            [headImage setClipsToBounds:YES];
            headImage.contentMode = UIViewContentModeScaleToFill;
            [cell.contentView addSubview:headImage];
            
            UILabel *contentLabel = [UILabel new];
            contentLabel.font = TEXT_FONT_LEVEL_2;
            contentLabel.textColor = TEXT_COLOR_LEVEL_3;
            contentLabel.numberOfLines=0;
            contentLabel.text = @"这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文";
            NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
            CGFloat conHighs = [contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth-30, 100000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes2 context:nil].size.height;
            [contentLabel sizeToFit];
            contentLabel.frame = CGRectMake(15, 30+headImage.bounds.size.height +conHigh, kScreenWidth-30, conHighs);
            [cell.contentView addSubview:contentLabel];
            return cell;
            
            

            
            
        }
        
        
    
    if (indexPath.section==3) {
        static NSString *cellId = @"cellId";
        LMCommentCell *cell = [[LMCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        tableView.separatorStyle = UITableViewCellSelectionStyleDefault;
        
        
        [cell setXScale:self.xScale yScale:self.yScaleNoTab];
        
        [cell setTitleString:@"果然我问问我吩咐我跟我玩嗡嗡图文无关的身份和她和热稳定"];
        return cell;
    }
    
    
    
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - LMActivityheadCell delegate -
- (void)cellWillApply:(LMActivityheadCell *)cell
{
    NSLog(@"**********报名");

}




#pragma mark UITextFieldDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length==0) {
        tipLabel.hidden=NO;
    }else{
        tipLabel.hidden=YES;
    }
}

//修改textView return键

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView  resignFirstResponder];
        textView.text=@"";
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    if (scrollView.contentOffset.y > 230-64) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        
        self.navigationController.navigationBar.hidden=YES;
        
        headerView.hidden=NO;
        
        
        
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        
    }else{
        self.navigationController.navigationBar.hidden=NO;
        [UIApplication sharedApplication].statusBarHidden = NO;
        headerView.hidden=YES;
    }
    

    
}

-(void)besureAction:(id)sender
{
    NSLog(@"*******************确认");
}




- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end