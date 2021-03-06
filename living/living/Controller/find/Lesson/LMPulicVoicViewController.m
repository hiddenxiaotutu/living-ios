//
//  LMPulicVoicViewController.m
//  living
//
//  Created by Ding on 2016/12/13.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMPulicVoicViewController.h"
#import "LMProjectCell.h"
#import "LMPulicVoicemsgViewCell.h"
#import "LMTimeButton.h"
#import "FitPickerView.h"
#import "FitDatePickerView.h"
#import "LMPublicVoiceRequest.h"
#import "LMPublicVoicProjectRequest.h"
#import "FirUploadImageRequest.h"
#import "ImageHelpTool.h"
#import "BabFilterAgePickerView.h"
#import "FitPickerThreeLevelView.h"
#import "UIImageView+WebCache.h"
#import "LMChoosehostViewController.h"
#import "LMTypeListViewController.h"

#import "DataBase.h"

@interface LMPulicVoicViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
UITextViewDelegate,
FitDatePickerDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIViewControllerTransitioningDelegate,
UIActionSheetDelegate,
FitPickerViewDelegate,
LMhostchooseProtocol,
LMTypeListProtocol

>
{
    LMPulicVoicemsgViewCell *msgCell;
    UIImagePickerController *pickImage;
    NSString *_imgURL;
    NSString *_imgProURL;
    NSInteger dateIndex;
    NSInteger timeIndex;
    NSString  *districtStr;//设置中间变量，获取县（区）的编码
    //    NSInteger imageIndex;
    NSString *eventUUid;
    
    NSInteger projectIndex;
    
    CGFloat _latitude;
    CGFloat _longitude;
    LMProjectCell * cell;
    NSInteger addImageIndex;
    
    NSMutableArray *projectImageArray;
    
    NSString *typeString;
    NSInteger  type;
    NSString *UserId;
    UIButton *publicButton;
    NSInteger index;
    NSString *useCounpon;
    
    
    NSString * typeName;
    NSString * typeStr;
    
    DataBase *db;
    
    //权限
    UIView *authorityView;
    UILabel *authorityTip;
    NSString *authorityString;
}

@property (nonatomic,retain)UITableView *tableView;
@end

@implementation LMPulicVoicViewController

static NSMutableArray *cellDataArray;


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![self hasPhotosAuthority] && [self hasCameraAuthority] && [self hasMicrophoneAuthority]) {
        authorityString = @"相册权限未开启";
    } else if ([self hasPhotosAuthority] && ![self hasCameraAuthority] && [self hasMicrophoneAuthority]) {
        authorityString = @"相机权限未开启";
    } else if ([self hasPhotosAuthority] && [self hasCameraAuthority] && ![self hasMicrophoneAuthority]) {
        authorityString = @"麦克风权限未开启";
    } else if (![self hasPhotosAuthority] && ![self hasCameraAuthority] && [self hasMicrophoneAuthority]) {
        authorityString = @"相册、相机权限未开启";
    } else if (![self hasPhotosAuthority] && [self hasCameraAuthority] && ![self hasMicrophoneAuthority]) {
        authorityString = @"相册、麦克风权限未开启";
    } else if ([self hasPhotosAuthority] && ![self hasCameraAuthority] && ![self hasMicrophoneAuthority]) {
        authorityString = @"相机、麦克风权限未开启";
    } else if (![self hasPhotosAuthority] && ![self hasCameraAuthority] && ![self hasMicrophoneAuthority]) {
        authorityString = @"相册、相机、麦克风权限未开启";
    } else if ([self hasPhotosAuthority] && [self hasCameraAuthority] && [self hasMicrophoneAuthority]) {
        if (authorityView && !authorityView.hidden) {
            authorityView.hidden = YES;
            
        }
        return;
    }
    [self addAuthorityView];
}
- (void)addAuthorityView {
    if (!authorityView) {
        authorityView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
        authorityView.backgroundColor = [UIColor whiteColor];
        authorityView.layer.borderWidth = 1;
        authorityView.layer.borderColor = BG_GRAY_COLOR.CGColor;
        [self.view addSubview:authorityView];
        
        authorityTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 100, 30)];
        authorityTip.text = authorityString;
        authorityTip.textColor = TEXT_COLOR_LEVEL_1;
        authorityTip.font = TEXT_FONT_LEVEL_1;
        [authorityView addSubview:authorityTip];
        
        UIButton *openAuthority = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(authorityTip.frame) + 10, 10, 70, 30)];
        [openAuthority setTitle:@"去开启" forState:UIControlStateNormal];
        [openAuthority setTitleColor:LIVING_COLOR forState:UIControlStateNormal];
        openAuthority.titleLabel.font = TEXT_FONT_LEVEL_1;
        openAuthority.clipsToBounds = YES;
        openAuthority.layer.cornerRadius = 2;
        openAuthority.layer.borderColor = LIVING_COLOR.CGColor;
        openAuthority.layer.borderWidth = 1;
        [openAuthority addTarget:self action:@selector(openAuthority:) forControlEvents:UIControlEventTouchUpInside];
        [authorityView addSubview:openAuthority];
    } else {
        if (authorityView.hidden) {
            authorityView.hidden = NO;
            authorityTip.text = authorityString;
        }
    }
}
- (void)openAuthority:(UIButton *)btn {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布语音课堂";
    cellDataArray=[NSMutableArray arrayWithCapacity:10];
    projectImageArray=[NSMutableArray arrayWithCapacity:10];
    
    for (int i=0; i<10; i++) {
        [projectImageArray addObject:@""];
    }
    
    [self projectDataStorageWithArrayIndex:0];
    
    [self creatUI];
    type = 1;
    UserId = @"";
    useCounpon = @"1";
    
}


- (void)creatUI
{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.keyboardDismissMode          = UIScrollViewKeyboardDismissModeOnDrag;
    
    //去分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"存草稿"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(saveDraft)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self creatFootView];
    
    //草稿箱
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setDataFromDraft];
    });
    
}

-(void)creatFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    footView.backgroundColor = [UIColor clearColor];
    
    publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publicButton setTitle:@"确认并发布" forState:UIControlStateNormal];
    publicButton.layer.cornerRadius = 5;
    publicButton.titleLabel.font = TEXT_FONT_LEVEL_2;
    publicButton.frame = CGRectMake(10, 65, kScreenWidth-20, 45);
    publicButton.backgroundColor = LIVING_COLOR;
    
    [publicButton addTarget:self action:@selector(publishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:publicButton];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"添加项目" forState:UIControlStateNormal];
    [addButton setTitleColor:LIVING_COLOR forState:UIControlStateNormal];
    addButton.titleLabel.font = TEXT_FONT_LEVEL_2;
    addButton.frame = CGRectMake(kScreenWidth/2-50, 5, 100, 30);
    
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:addButton];
    
    
    self.tableView.tableFooterView = footView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return cellDataArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 490 +kScreenWidth*3/5+90+45;
    }
    if (indexPath.section==1) {
        return 340;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        commentView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:commentView];
        
        UILabel *commentLabel = [UILabel new];
        commentLabel.font = [UIFont systemFontOfSize:13.f];
        commentLabel.textColor = LIVING_COLOR;
        commentLabel.text = @"课程信息";
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
    
    
    if (section==1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 35)];
        commentView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:commentView];
        
        UILabel *commentLabel = [UILabel new];
        commentLabel.font = [UIFont systemFontOfSize:13.f];
        commentLabel.textColor = LIVING_COLOR;
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
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 35;
    }
    if (section==1) {
        return 40;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        static NSString *cellID = @"cellID";
        msgCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!msgCell) {
            msgCell = [[LMPulicVoicemsgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        msgCell.selectionStyle = UITableViewCellSelectionStyleNone;
        msgCell.titleTF.delegate = self;
        msgCell.phoneTF.delegate = self;
        msgCell.nameTF.delegate = self;
        msgCell.freeTF.delegate =self;
        msgCell.VipFreeTF.delegate = self;
        msgCell.joincountTF.delegate = self;
        msgCell.couponTF.delegate = self;
        msgCell.applyTextView.delegate = self;
        
        msgCell.titleTF.tag = 100;
        msgCell.phoneTF.tag = 100;
        msgCell.nameTF.tag = 100;
        msgCell.freeTF.tag =100;
        msgCell.VipFreeTF.tag = 100;
        msgCell.joincountTF.tag = 100;
        msgCell.couponTF.tag = 100;
        
        msgCell.category.titleLabel.text = typeName;
        [msgCell.category addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];

        [msgCell.dateButton addTarget:self action:@selector(beginDateAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [msgCell.endDateButton addTarget:self action:@selector(endDateAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [msgCell.hostButton addTarget:self action:@selector(hostButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [msgCell.imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [msgCell.imageButton setTag:0];
        
        
        [msgCell.UseButton addTarget:self action:@selector(useCounpon) forControlEvents:UIControlEventTouchUpInside];
        [msgCell.unUseButton addTarget:self action:@selector(UNuseCounpon) forControlEvents:UIControlEventTouchUpInside];
        
        
        return msgCell;
    }
    if (indexPath.section==1) {
        
        static NSString *cellId = @"cellId";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell = [[LMProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.title.delegate = self;
            cell.includeTF.delegate = self;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.title setTag:indexPath.row];
        [cell.includeTF setTag:indexPath.row];
        cell.cellndex = indexPath.row;
        cell.tag = indexPath.row;
        
        cell.title.text=cellDataArray[indexPath.row][@"title"];
        
        cell.includeTF.text=cellDataArray[indexPath.row][@"content"];
        
        if ([projectImageArray[indexPath.row] isKindOfClass:[UIImage class]]) {
            UIImage *image=(UIImage *)projectImageArray[indexPath.row];
            [cell.imgView setImage:image];
        }else if ([projectImageArray[indexPath.row] isKindOfClass:[NSString class]]) {
            if (![projectImageArray[indexPath.row] isEqualToString:@""]) {
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:projectImageArray[indexPath.row]]];
            } else {
                [cell.imgView setImage:[UIImage imageNamed:@""]];
            }
        }
        
        [cell.deleteBt addTarget:self action:@selector(closeCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBt setTag:indexPath.row];
        
        [cell.eventButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.eventButton setTag:indexPath.row+10];
        
        [cell.deleteBt setHidden:NO];
        
        if (cellDataArray.count==1) {
            if (indexPath.row==0) {
                [cell.deleteBt setHidden:YES];
            }else{
                [cell.deleteBt setHidden:NO];
            }
        }
        
        if ([cellDataArray[indexPath.row][@"content"] isEqualToString:@""]&&cellDataArray[indexPath.row][@"content"]) {
            [cell.textLab setHidden:NO];
        }else{
            [cell.textLab setHidden:YES];
        }
        
        return cell;
    }
    return nil;
}
#pragma mark - 选择分类代理
- (void)backLiveName:(NSString *)liveRoom
{
    typeName = liveRoom;
    if ([liveRoom isEqualToString:@"美丽"]) {
        typeStr = @"beautiful";
    }
    if ([liveRoom isEqualToString:@"幸福"]) {
        typeStr = @"happiness";
    }
    if ([liveRoom isEqualToString:@"健康"]) {
        typeStr = @"healthy";
    }
    if ([liveRoom isEqualToString:@"美食"]) {
        typeStr = @"delicious";
    }
    
    [self.tableView reloadData];
}

- (void)chooseType:(id)sender{
    LMTypeListViewController * typeVC = [[LMTypeListViewController alloc] init];
    typeVC.name = @"课程分类";
    typeVC.delegate     = self;
    
    [self.navigationController pushViewController:typeVC animated:YES];
}

//是否允许使用优惠券
- (void)useCounpon
{
    NSLog(@"使用优惠券");
    useCounpon = @"1";
    msgCell.UseButton.chooseImage.backgroundColor = LIVING_COLOR;
    msgCell.UseButton.chooseImage.layer.borderColor = [UIColor whiteColor].CGColor;
    msgCell.unUseButton.chooseImage.backgroundColor = [UIColor clearColor];
    msgCell.unUseButton.chooseImage.layer.borderColor = [UIColor blackColor].CGColor;
    
}

- (void)UNuseCounpon
{
    NSLog(@"不使用优惠券");
    useCounpon = @"2";
    msgCell.unUseButton.chooseImage.backgroundColor = LIVING_COLOR;
    msgCell.unUseButton.chooseImage.layer.borderColor = [UIColor whiteColor].CGColor;
    msgCell.UseButton.chooseImage.backgroundColor = [UIColor clearColor];
    msgCell.UseButton.chooseImage.layer.borderColor = [UIColor blackColor].CGColor;
}





- (void)closeCell:(UIButton *)button
{
    NSInteger row=button.tag;
    
    [cellDataArray removeObjectAtIndex:row];
    
    [projectImageArray removeObjectAtIndex:row];
    
    [self refreshData];
}

- (void)hostButtonAction
{
    LMChoosehostViewController    *typeVC     = [[LMChoosehostViewController alloc] init];
    typeVC.delegate     = self;
    
    [self.navigationController pushViewController:typeVC animated:YES];
}

- (void)backhostName:(NSString *)liveRoom andId:(NSInteger )userId
{
    type = 2;
    typeString  = liveRoom;
    msgCell.hostButton.textLabel.text = liveRoom;
    UserId = [NSString stringWithFormat:@"%ld",(long)userId];
    [self.tableView reloadData];
}


- (void)beginDateAction:(id)sender
{
    [self.view endEditing:YES];
    dateIndex = 0;
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate;
    
    currentDate = [NSDate date];
    
    [FitDatePickerView showWithMinimumDate:currentDate
                               MaximumDate:[formatter dateFromString:@"2950-01-01"]
                               CurrentDate:currentDate
                                      Mode:UIDatePickerModeDateAndTime
                                  Delegate:self];
}

- (void)endDateAction:(id)sender
{
    [self.view endEditing:YES];
    dateIndex = 1;
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate;
    if ([msgCell.dateButton.textLabel.text isEqual:@"请选择活动开始时间"]) {
        currentDate = [NSDate date];
    }else{
        
        NSString *dateString=msgCell.dateButton.textLabel.text;
        
        currentDate=[formatter dateFromString:dateString];
        
    }
    
    [FitDatePickerView showWithMinimumDate:currentDate
                               MaximumDate:[formatter dateFromString:@"2950-01-01 00:00:00"]
                               CurrentDate:currentDate
                                      Mode:UIDatePickerModeDateAndTime
                                  Delegate:self];
}


#pragma mark ======================活动==项目活动增加图片

- (void)imageButtonAction:(UIButton *)button
{
    addImageIndex=button.tag;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相册", @"拍照",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    actionSheet = nil;
}

#pragma mark - 日期选择

- (void)didSelectedDate:(NSDate *)date
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    if (dateIndex == 0) {
        
        msgCell.dateButton.textLabel.text   = [formatter stringFromDate:date];
    }
    if (dateIndex == 1) {
        
        msgCell.endDateButton.textLabel.text   = [formatter stringFromDate:date];
    }
}


#pragma mark  textView代理方法

- (void)textViewDidChange:(UITextView *)textView1
{
    if ([textView1 isEqual:msgCell.applyTextView]) {
        
        if (msgCell.applyTextView.text.length>0) {
            msgCell.msgLabel.hidden = YES;
        } else {
            msgCell.msgLabel.hidden  = NO;
        }
        
    }else{

    
        NSArray *array = self.tableView.visibleCells;
        
        for (UIView * view in array) {
            if ([view isKindOfClass:[LMProjectCell class]]) {
                LMProjectCell * cells = (LMProjectCell *)view;
                if (textView1.text.length==0)
                {
                    [cells.textLab setHidden:NO];
                }else{
                    [cells.textLab setHidden:YES];
                }
            }
            
        }
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{

    
    [self scrollEditingRectToVisible:textView.frame EditingView:textView];
}

#pragma mark 项目介绍编辑结束

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView isEqual:msgCell.applyTextView]) {
        
    } else {
        
        NSInteger row=textView.tag;
        
        [self modifyCellDataContent:row andText:textView.text];
    }
    
    return YES;
}

#pragma mark 编辑单元格项目介绍

- (void)modifyCellDataContent:(NSInteger)row andText:(NSString *)text{
    
    if (cellDataArray.count > row) {

        NSMutableDictionary *dic=cellDataArray[row];
        
        if ([text isEqualToString:@""]) {
            
            [dic setObject:@"" forKey:@"content"];
        }else{
            [dic setObject:text forKey:@"content"];
        }
    }
    [self refreshData];
}

#pragma mark  UITextField代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark 标题编辑结束

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    if (textField.tag==100) {
        return YES;
    }
    NSInteger row=textField.tag;
    
    [self modifyCellDataTitle:row andText:textField.text];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollEditingRectToVisible:textField.frame EditingView:textField];
    [textField addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textLengthChange:(UITextField *)textField
{
    NSString *toBeString;
    NSString *lang;
    NSInteger MAX_STARWORDS_LENGTH = 0;
    NSInteger textFiledTag = 0;
    if (textField == msgCell.nameTF) {
        toBeString = msgCell.nameTF.text;
        lang = [textField.textInputMode primaryLanguage];
        MAX_STARWORDS_LENGTH = 4;
        textFiledTag = 1;
    }
    
    if (textField == msgCell.titleTF) {
        toBeString = msgCell.titleTF.text;
        lang = [textField.textInputMode primaryLanguage];
        MAX_STARWORDS_LENGTH = 30;
        textFiledTag = 2;
    }
    if (textField == msgCell.VipFreeTF) {
        toBeString = msgCell.VipFreeTF.text;
        lang = [textField.textInputMode primaryLanguage];
        MAX_STARWORDS_LENGTH = 6;
        textFiledTag = 3;
    }
    if (textField == msgCell.couponTF) {
        toBeString = msgCell.couponTF.text;
        lang = [textField.textInputMode primaryLanguage];
        MAX_STARWORDS_LENGTH = 6;
        textFiledTag = 3;
    }
    if (textField == msgCell.freeTF) {
        toBeString = msgCell.freeTF.text;
        lang = [textField.textInputMode primaryLanguage];
        MAX_STARWORDS_LENGTH = 6;
        textFiledTag = 3;
    }
    
    if (textField == msgCell.joincountTF) {
        toBeString = msgCell.joincountTF.text;
        lang = [textField.textInputMode primaryLanguage];
        MAX_STARWORDS_LENGTH = 3;
        textFiledTag = 4;
    }
    
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                if (textFiledTag == 1) {
                   [self textStateHUD:@"最多输入4个字~"];
                }
                if (textFiledTag == 2) {
                    [self textStateHUD:@"最多输入30个字哦~"];
                }
                if (textFiledTag == 3) {
                    [self textStateHUD:@"最多不能超过100万哦~"];
                }
                if (textFiledTag == 4) {
                    [self textStateHUD:@"最多不能超过500人哦~"];
                }
                
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


#pragma mark 编辑单元格标题

- (void)modifyCellDataTitle:(NSInteger)row andText:(NSString *)text{
    
    NSMutableDictionary *dic=cellDataArray[row];
    
    if ([text isEqualToString:@""]) {
        
        [dic setObject:@"" forKey:@"title"];
    }else{
        [dic setObject:text forKey:@"title"];
    }
    
    
    [self refreshData];
    
}

#pragma mark 单元格刚创建后的数据

- (void)projectDataStorageWithArrayIndex:(NSInteger)indexs
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:@"" forKey:@"title"];
    [dic setObject:@"" forKey:@"content"];
    [dic setObject:@"" forKey:@"image"];
    
    [cellDataArray insertObject:dic atIndex:indexs];
}

#pragma mark UIImagePickerController代理函数

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [pickImage dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    if (addImageIndex==0) {
        //设置头像图片
        msgCell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        msgCell.imgView.clipsToBounds = YES;
        [msgCell.imgView setImage:image];
    }else{
        
        [projectImageArray replaceObjectAtIndex:addImageIndex-10 withObject:image];
    }
    
    [self refreshData];
    
    [self getImageURL:image];
    
    [pickImage dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 编辑单元格项目活动图片

-(void)modifyCellDataImage:(NSInteger)row andImageUrl:(NSString *)imageUrl{
    
    NSMutableDictionary *dic=cellDataArray[row];
    
    if (imageUrl) {
        [dic setObject:imageUrl forKey:@"image"];
    }else{
        [dic setObject:@"" forKey:@"image"];
    }
}

#pragma mark 获取头像的url

- (void)getImageURL:(UIImage*)image
{
    if (![CheckUtils isLink]) {
        
        [self textStateHUD:@"无网络连接"];
        return;
    }
    
    if (addImageIndex == 0) {
        
        FirUploadImageRequest   *request    = [[FirUploadImageRequest alloc] initWithFileName:@"file"];
        UIImage *headImage = [ImageHelpTool scaleImage:image];
        request.imageData   = UIImageJPEGRepresentation(headImage, 1);
        
        [self initStateHud];
        
        HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                               completed:^(NSString *resp, NSStringEncoding encoding){
                                                   
                                                   [self performSelectorOnMainThread:@selector(hideStateHud)
                                                                          withObject:nil
                                                                       waitUntilDone:YES];
                                                   NSDictionary    *bodyDict   = [VOUtil parseBody:resp];
                                                   
                                                   NSString    *result = [bodyDict objectForKey:@"result"];
                                                   
                                                   if (result && [result isKindOfClass:[NSString class]]
                                                       && [result isEqualToString:@"0"]) {
                                                       NSString    *imgUrl = [bodyDict objectForKey:@"attachment_url"];
                                                       if (imgUrl && [imgUrl isKindOfClass:[NSString class]]) {
                                                           
                                                           _imgURL=imgUrl;
                                                           
                                                       }
                                                   }
                                               } failed:^(NSError *error) {
                                                   [self hideStateHud];
                                               }];
        [proxy start];
    }else{
        [self initStateHud];
        FirUploadImageRequest   *request    = [[FirUploadImageRequest alloc] initWithFileName:@"file"];
        UIImage *headImage = [ImageHelpTool scaleImage:image];
        request.imageData   = UIImageJPEGRepresentation(headImage, 1);
        
        
        HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                               completed:^(NSString *resp, NSStringEncoding encoding){
                                                   
                                                   [self performSelectorOnMainThread:@selector(hideStateHud)
                                                                          withObject:nil
                                                                       waitUntilDone:YES];
                                                   
                                                   NSDictionary    *bodyDict   = [VOUtil parseBody:resp];
                                                   
                                                   NSString    *result = [bodyDict objectForKey:@"result"];
                                                   
                                                   if (result && [result isKindOfClass:[NSString class]]
                                                       && [result isEqualToString:@"0"]) {
                                                       NSString    *imgUrl = [bodyDict objectForKey:@"attachment_url"];
                                                       if (imgUrl && [imgUrl isKindOfClass:[NSString class]]) {
                                                           
                                                           [self modifyCellDataImage:addImageIndex-10 andImageUrl:imgUrl];
                                                       }
                                                   }
                                               } failed:^(NSError *error) {
                                                   [self hideStateHud];
                                               }];
        [proxy start];
        
    }
}

#pragma mark UIActionSheet ======================代理函数

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    pickImage=[[UIImagePickerController alloc]init];
    
    [pickImage setDelegate:self];
    pickImage.transitioningDelegate  = self;
    pickImage.modalPresentationStyle = UIModalPresentationCustom;
    
    if (buttonIndex==0)
    {//图库
        [pickImage setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:pickImage animated:YES completion:nil];
    }
    if (buttonIndex==1)
    {//摄像头
        //判断后边的摄像头是否可用
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
        {
            [pickImage setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:pickImage animated:YES completion:nil];
        }
        //判断前边的摄像头是否可用
        else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            [pickImage setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:pickImage animated:YES completion:nil];
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:@"相机不可用"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
            
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

#pragma mark --判断项目标题是否为空

- (BOOL)judgeProjectTitle
{
    for (NSDictionary *dic in cellDataArray) {
        if ([dic[@"title"] isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark  --确认并发布按钮

-(void)publishButtonAction:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *startstring = [NSString stringWithFormat:@"%@",msgCell.dateButton.textLabel.text];
    NSString *endString =[NSString stringWithFormat:@"%@",msgCell.endDateButton.textLabel.text];
    
    if (!(msgCell.titleTF.text.length>0)) {
        [ self textStateHUD:@"请输入活动标题"];
        return;
    }
    if (!(msgCell.phoneTF.text.length>0)) {
        [ self textStateHUD:@"请输入联系电话"];
        return;
    }
    if (!(msgCell.nameTF.text.length>0)) {
        [ self textStateHUD:@"请输入联系人名字"];
        return;
    }
    if (!(msgCell.freeTF.text.length>0)) {
        [ self textStateHUD:@"请输入活动费用"];
        return;
    }
    if (!(msgCell.VipFreeTF.text.length>0)) {
        [ self textStateHUD:@"请输入会员费用"];
        return;
    }
    
    if (!(msgCell.couponTF.text.length>0)) {
        [ self textStateHUD:@"请输入加盟商费用"];
        return;
    }
    
    if ((msgCell.joincountTF.text.length>0)) {
        if ([msgCell.joincountTF.text intValue]>500) {
            [ self textStateHUD:@"课程人数不能超过500人~"];
            return;
        }
    }
    
    if ([startstring isEqual:@"请选择活动开始时间"]) {
        [ self textStateHUD:@"请选择开始时间"];
        return;
    }
    if ([endString isEqual:@"请选择活动结束时间"]) {
        [ self textStateHUD:@"请选择结束时间"];
        return;
    }
    


    
    if (!msgCell.imgView.image) {
        [ self textStateHUD:@"请选择封面图片"];
        return;
    }
    
    if (![self judgeProjectTitle]) {
        [self textStateHUD:@"活动项目标题不能为空"];
        return;
    }
    
    [self initStateHud];
    
    
    if ([msgCell.hostButton.textLabel.text isEqualToString:@"点击选择主持(非必选项)"]) {
        UserId = nil;
    }
     publicButton.userInteractionEnabled = YES;

    LMPublicVoiceRequest *request = [[LMPublicVoiceRequest alloc] initWithvoice_title:msgCell.titleTF.text Contact_phone:msgCell.phoneTF.text Contact_name:msgCell.nameTF.text Per_cost:msgCell.freeTF.text Discount:msgCell.VipFreeTF.text Start_time:startstring End_time:endString image:_imgURL host:UserId limit_number:[msgCell.joincountTF.text intValue]  notices:msgCell.applyTextView.text franchiseePrice:msgCell.couponTF.text available:useCounpon category:typeStr];
    HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                           completed:^(NSString *resp, NSStringEncoding encoding) {
                                               
                                               [self performSelectorOnMainThread:@selector(getEventDataResponse:)
                                                                      withObject:resp
                                                                   waitUntilDone:YES];
                                           } failed:^(NSError *error) {
                                               
                                               [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                      withObject:@"网络错误"
                                                                   waitUntilDone:YES];
                                                publicButton.userInteractionEnabled = YES;
                                           }];
    [proxy start];
    
}

- (void)getEventDataResponse:(NSString *)resp
{
    NSDictionary *bodyDic = [VOUtil parseBody:resp];
    
    if (!bodyDic) {
        [self textStateHUD:@"发布失败"];
         publicButton.userInteractionEnabled = YES;
    }else{
        if ([[bodyDic objectForKey:@"result"] isEqual:@"0"]) {
            
            NSString *string = [bodyDic objectForKey:@"voice_uuid"];
            eventUUid = string;
            
            [self publicProject];
            
        }else{
            NSString *string = [bodyDic objectForKey:@"description"];
            [self textStateHUD:string];
             publicButton.userInteractionEnabled = YES;
        }
    }
}

#pragma mark --发布活动项目执行请求

- (void)publicProject
{
    
        
        NSDictionary *dic=cellDataArray[index];
        
        LMPublicVoicProjectRequest *request = [[LMPublicVoicProjectRequest alloc]initWithVoice_uuid:eventUUid Project_title:dic[@"title"] Project_dsp:dic[@"content"] Project_imgs:dic[@"image"]];
        
        HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                               completed:^(NSString *resp, NSStringEncoding encoding) {
                                                   
                                                   [self performSelectorOnMainThread:@selector(getEventPublicProjectDataResponse:)
                                                                          withObject:resp
                                                                       waitUntilDone:YES];
                                               } failed:^(NSError *error) {
                                                   
                                                   [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                          withObject:@"网络错误"
                                                                       waitUntilDone:YES];
                                                    publicButton.userInteractionEnabled = YES;
                                               }];
        [proxy start];
    
}

- (void)getEventPublicProjectDataResponse:(NSString *)resp
{
    NSDictionary *bodyDic = [VOUtil parseBody:resp];
    
    if (!bodyDic) {
        [self textStateHUD:@"发布失败"];
         publicButton.userInteractionEnabled = YES;
    }else{
        if ([[bodyDic objectForKey:@"result"] isEqual:@"0"]) {
            
            index++;
            if (index<cellDataArray.count) {
                [self publicProject];
            }else{
            [self textStateHUD:@"发布成功"];
            //删除草稿
            if (_draftDic) {
                db = [DataBase sharedDataBase];
                [db deleteFromDraftWithID:_draftDic[@"id"]];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload"
                 
                                                                    object:nil];
            });
            
            }
        }else{
            NSString *string = [bodyDic objectForKey:@"description"];
            [self textStateHUD:string];
             publicButton.userInteractionEnabled = YES;
        }
    }
}

#pragma mark  --添加项目

- (void)addButtonAction:(id)sender
{
    NSInteger length=cellDataArray.count;
    
    if (length==5) {
        [self textStateHUD:@"最多可添加五个项目"];
        return;
    }
    
    [self projectDataStorageWithArrayIndex:length];
    [self refreshData];
}


- (void)scrollEditingRectToVisible:(CGRect)rect EditingView:(UIView *)view
{
    CGFloat     keyboardHeight  = 280;
    
    if (view && view.superview) {
        rect    = [self.tableView convertRect:rect fromView:view.superview];
    }
    
    if (rect.origin.y < kScreenHeight - keyboardHeight - rect.size.height - 64) {
        return;
    }
    
    [self.tableView setContentOffset:CGPointMake(0, rect.origin.y+15 - (kScreenHeight - keyboardHeight - rect.size.height)) animated:YES];
}

- (void)refreshData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}


#pragma mark - 存草稿
- (void)saveDraft {
    NSLog(@"课程存草稿");
    NSString *startstring = [NSString stringWithFormat:@"%@",msgCell.dateButton.textLabel.text];
    NSString *endString =[NSString stringWithFormat:@"%@",msgCell.endDateButton.textLabel.text];
//    LMPublicVoiceRequest *request = [[LMPublicVoiceRequest alloc]
//                                     initWithvoice_title:msgCell.titleTF.text
//                                     Contact_phone:msgCell.phoneTF.text
//                                     Contact_name:msgCell.nameTF.text
//                                     Per_cost:msgCell.freeTF.text
//                                     Discount:msgCell.VipFreeTF.text
//                                     Start_time:startstring
//                                     End_time:endString
//                                     image:_imgURL
//                                     host:UserId
//                                     limit_number:[msgCell.joincountTF.text intValue]
//                                     notices:msgCell.applyTextView.text
//                                     franchiseePrice:msgCell.couponTF.text
//                                     available:useCounpon
//                                     category:typeStr];
    
    db = [DataBase sharedDataBase];
    NSString *latitudeString;
    NSString *longitudeString;
    if (_latitude ==0 &&_longitude==0) {
        latitudeString = @"";
        longitudeString = @"";
    }else{
        latitudeString = [NSString stringWithFormat:@"%f",_latitude];
        longitudeString =[NSString stringWithFormat:@"%f",_longitude] ;
    }

    
    NSString *msgTitle = @"";
    NSString *msgPhone = @"";
    NSString *msgName = @"";
    
    NSString *msgFee = @"";
    NSString *msgVipFee = @"";
    NSString *msgCouponFee = @"";
    
    NSString *msgStartTime = @"";
    NSString *msgEndTime = @"";
    
    NSString *msgImgUrl = @"";
    NSString *host = @"";
    NSString *hostStr = @"";
    
    NSString *msgLatitude = @"";
    NSString *msgLongitude = @"";
    
    NSString *msgLimit = @"";
    NSString *msgNotice = @"";
    NSString *msgAvailable = @"";
    
    NSString *msgCategory = @"";
    NSString *msgType = @"";
    
    if (msgCell.titleTF.text) {
        msgTitle = msgCell.titleTF.text;
    }
    if (msgCell.phoneTF.text) {
        msgPhone = msgCell.phoneTF.text;
    }
    if (msgCell.nameTF.text) {
        msgName = msgCell.nameTF.text;
    }
    //////
    if (msgCell.freeTF.text) {
        msgFee = msgCell.freeTF.text;
    }
    if (msgCell.VipFreeTF.text) {
        msgVipFee = msgCell.VipFreeTF.text;
    }
    if (msgCell.couponTF.text) {
        msgCouponFee = msgCell.couponTF.text;
    }
    //////
    if (startstring) {
        msgStartTime = startstring;
    }
    if (endString) {
        msgEndTime = endString;
    }
    
    //////
    if (_imgURL) {
        msgImgUrl = _imgURL;
    }
    if (UserId) {
        host = UserId;
    }
    if (typeString) {
        hostStr = typeString;
    }
    //////
    if (latitudeString) {
        msgLatitude = latitudeString;
    }
    if (longitudeString) {
        msgLongitude = longitudeString;
    }
    //////
    if (msgCell.joincountTF.text) {
        msgLimit = msgCell.joincountTF.text;
    }
    if (msgCell.applyTextView.text) {
        msgNotice = msgCell.applyTextView.text;
    }
    if (useCounpon) {
        msgAvailable = useCounpon;
    }
    if (typeName) {
        msgCategory = typeName;
    }
    if (typeStr) {
        msgType = typeStr;
    }

    
    NSDictionary *contentDic = @{@"headData":@{@"title":msgTitle,
                                               @"phone":msgPhone,
                                               @"name":msgName,
                                               @"fee":msgFee,
                                               @"vipFee":msgVipFee,
                                               @"couponFee":msgCouponFee,
                                               @"start":msgStartTime,
                                               @"end":msgEndTime,
                                               @"imgUrl":msgImgUrl,
                                               @"host":host,
                                               @"hostStr":hostStr,
                                               @"latitude":msgLatitude,
                                               @"longitude":msgLongitude,
                                               @"limitNum":msgLimit,
                                               @"notices":msgNotice,
                                               @"available":msgAvailable,
                                               @"category":msgCategory,
                                               @"typeStr":msgType
                                               },
                                 @"cellData":cellDataArray};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *contentStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd hh:mm";
    NSString *dateStr = [format stringFromDate:[NSDate date]];
    NSDictionary *info = @{@"person_id":[FitUserManager sharedUserManager].uuid, @"title":msgCell.titleTF.text, @"desp":msgNotice, @"category":msgCell.category.titleLabel.text, @"type":@"class", @"content":contentStr, @"time":dateStr};
    NSLog(@"%@", info);
    if (_draftDic) {
        //修改
        if([db updateDraft:_draftDic[@"id"] withInfo:info]) {
            [self textStateHUD:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self textStateHUD:@"保存失败,请重试"];
        }
        return;
    }
    if([db addToDraft:info]) {
        [self textStateHUD:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self textStateHUD:@"保存失败,请重试"];
    }
}

#pragma mark - 从草稿箱填充数据
- (void)setDataFromDraft {
    if (!_draftDic) {
        return;
    }
    NSString *contentStr = _draftDic[@"content"];
    NSData *contentData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *headDic = contentDic[@"headData"];
    
    msgCell.titleTF.text = headDic[@"title"];
    msgCell.phoneTF.text = headDic[@"phone"];
    msgCell.nameTF.text = headDic[@"name"];
    
    msgCell.freeTF.text = headDic[@"fee"];
    msgCell.VipFreeTF.text = headDic[@"vipFee"];
    msgCell.couponTF.text = headDic[@"couponFee"];
    
    
    //时间判断
    if (headDic[@"start"] || headDic[@"end"] ) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        if (headDic[@"start"]) {
            NSDate *startDate = [formatter dateFromString:headDic[@"start"]];
            NSTimeInterval startTime = [startDate timeIntervalSince1970];
            if (startTime > currentTime) {
                msgCell.dateButton.textLabel.text = headDic[@"start"];
            }
        }
        if (headDic[@"end"]) {
            NSDate *endDate = [formatter dateFromString:headDic[@"end"]];
            NSTimeInterval endTime = [endDate timeIntervalSince1970];
            if (endTime > currentTime) {
                msgCell.endDateButton.textLabel.text = headDic[@"end"];
            }
        }
    }
    
    _imgURL = headDic[@"imgUrl"];
    if (_imgURL && ![_imgURL isEqualToString:@""]) {
        [msgCell.imgView sd_setImageWithURL:[NSURL URLWithString:_imgURL]];
        msgCell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        msgCell.imgView.clipsToBounds = YES;
    }
    
    
    if (headDic[@"host"] && ![headDic[@"host"] isEqualToString:@""]) {
        UserId = headDic[@"host"];
    }
    if (headDic[@"hostStr"] && ![headDic[@"hostStr"] isEqualToString:@""]) {
        type = 2;
        typeString = headDic[@"hostStr"];
        msgCell.hostButton.textLabel.text = typeString;
    }
    
    _latitude = [headDic[@"latitude"] doubleValue];
    _longitude = [headDic[@"longitude"] doubleValue];
    
    msgCell.joincountTF.text = headDic[@"limitNum"];
    
    if (headDic[@"notices"] && ![headDic[@"notices"] isEqualToString:@""]) {
        msgCell.applyTextView.text = headDic[@"notices"];
        msgCell.msgLabel.hidden = YES;
    }
    
    if (headDic[@"category"] && ![headDic[@"category"] isEqualToString:@""]) {
        typeName = headDic[@"category"];
    }
    if (headDic[@"typeStr"] && ![headDic[@"typeStr"] isEqualToString:@""]) {
        typeStr = headDic[@"typeStr"];
    }
    
    
    useCounpon = headDic[@"available"];
    if ([useCounpon isEqualToString:@"1"]) {
        [self useCounpon];
    } else if ([useCounpon isEqualToString:@"2"]) {
        [self UNuseCounpon];
    }
    
    
    cellDataArray = contentDic[@"cellData"];
    NSLog(@"%@", contentDic);
    NSLog(@"%@", cellDataArray);
    
    for (int i = 0; i < cellDataArray.count; i++) {
        NSDictionary *dic = cellDataArray[i];
        [projectImageArray replaceObjectAtIndex:i withObject:dic[@"image"]];
        
    }
    NSLog(@"=======%@", projectImageArray);
    [self.tableView reloadData];
    
}
@end

