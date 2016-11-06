//
//  DYLoginViewController.m
//  dirty
//
//  Created by Ding on 16/8/23.
//  Copyright © 2016年 Huasheng. All rights reserved.
//

#import "LMLoginViewController.h"
#import "FitNavigationController.h"
#import "NSString+StringHelper.h"
#import "LMWebViewController.h"
#import "LMGetCaptchaRequest.h"
#import "LMloginRequest.h"

#import "LMRegisterViewController.h"

#define TOKEN @"dirty2016"

//微信授权
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "Constant.h"
#import "LMWXLoginRequest.h"

@interface LMLoginViewController ()
<
UITextFieldDelegate,
WXApiManagerDelegate,
WXApiDelegate
>
{
    UITextField     *_phoneTF;
    UITextField     *_codeTF;
    NSString        *_uuid;
    NSString        *_password;
    BOOL            _ifEdit;
    
    UILabel         *codeBtn;
    NSTimer         *_timer;
    
    int              _number;
    UIImageView     *_doneImg;
    UIButton        *_loginBtn;
    NSString        *gender;
    NSString        *privileges;
    NSString        *franchisee;
    NSString        *vipString;
}

@end

@implementation LMLoginViewController


+ (void)presentInViewController:(UIViewController *)viewController Animated:(BOOL)animated
{
    if (!viewController) {
        return;
    }
    
    LMLoginViewController      *loginVC    = [[LMLoginViewController alloc] init];
    FitNavigationController *navVC      = [[FitNavigationController alloc] initWithRootViewController:loginVC];
    
    [viewController presentViewController:navVC animated:animated completion:^{
        
    }];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title  = @"登录";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    _number=60;
    
    
}

- (void)createUI
{
    [super createUI];
    [WXApiManager sharedManager].delegate = self;
    
    self.tableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorInset       = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    self.tableView.tableHeaderView = headView;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(submitBtnPressed)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIView  *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UILabel *hintLbl    = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 15)];
    hintLbl.textAlignment   = NSTextAlignmentCenter;
    hintLbl.font            = TEXT_FONT_LEVEL_3;

    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击登录即理解并且同意《腰果生活服务协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:LIVING_REDCOLOR range:NSMakeRange(11,str.length-11)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0,11)];
    
    hintLbl.attributedText = str;
    
    [footerView addSubview:hintLbl];
    [footerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(lookProtocol)]];
    
    UIBarButtonItem *leftButton     = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:nil];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.tableView.tableFooterView  = footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70+kScreenHeight/3;
    }
    if (indexPath.row == 1) {
        return 90;
    }
    if (indexPath.row == 2) {
        return 60;
    }
    if (indexPath.row == 3) {
        return 60;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString    *CELL_IDENTIFI  = @"CELL_IDENTIFI";
    
    UITableViewCell *cell   = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFI];
    
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    
    if (indexPath.row == 0) {

        
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight/3)];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-45, kScreenHeight/6-45, 90, 90)];
        iconView.layer.cornerRadius = 20;
        iconView.clipsToBounds = YES;
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.image = [UIImage imageNamed:@"editMsg"];
        [headView addSubview:iconView];
        [cell.contentView addSubview:headView];
        
        UILabel *appName = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight/6+65, 100, 30)];
        appName.text = @"腰果生活";
        appName.textColor = TEXT_COLOR_LEVEL_1;
        appName.textAlignment = NSTextAlignmentCenter;
        appName.font = [UIFont systemFontOfSize:18];
        [cell.contentView addSubview:appName];
        
        
        
        _phoneTF                = [[UITextField alloc] initWithFrame:CGRectMake(20, 30+kScreenHeight/3, kScreenWidth - 120, 50)];
        _phoneTF.keyboardType   = UIKeyboardTypePhonePad;
        _phoneTF.placeholder    = @"请输入手机号码";
        _phoneTF.delegate       = self;
        _phoneTF.textColor      = [UIColor blackColor];
        [_phoneTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        [cell.contentView addSubview:_phoneTF];
        
        UIView *botLine = [[UIView alloc] initWithFrame:CGRectMake(20, 79+kScreenHeight/3, kScreenWidth - 40, 0.5)];
        
        botLine.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:botLine];
    }
    if (indexPath.row == 1) {
        _codeTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth - 140, 50)];
        _codeTF.placeholder     = @"请输入验证号码";
        _codeTF.font = [UIFont systemFontOfSize:17];
        _codeTF.keyboardType    = UIKeyboardTypePhonePad;
        _codeTF.delegate = self;
        _codeTF.tag = 0412;
        [_codeTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        _codeTF.textColor       = [UIColor blackColor];
        
        [cell.contentView addSubview:_codeTF];
        
        UILabel     *lbl    = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 111, 10, 10, 50)];
        
        lbl.text            = @"/";
        lbl.font            = [UIFont boldSystemFontOfSize:18];
        lbl.textColor       = LIVING_REDCOLOR;
        lbl.textAlignment   = NSTextAlignmentCenter;
        [cell.contentView addSubview:lbl];
        
        codeBtn                    = [[UILabel alloc]init];
        codeBtn.layer.cornerRadius = 5;
        codeBtn.frame              = CGRectMake(kScreenWidth - 108, 10, 100, 50);
        codeBtn.text               = @"获取验证码";
        codeBtn.textColor          = LIVING_REDCOLOR;
        codeBtn.userInteractionEnabled = YES;
        codeBtn.clipsToBounds      = YES;
        codeBtn.textAlignment      = NSTextAlignmentCenter;
        codeBtn.font                = TEXT_FONT_LEVEL_1;
        UITapGestureRecognizer      *codeButTap    = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBtnPressed)];
        [codeBtn addGestureRecognizer:codeButTap];
        [cell.contentView addSubview:codeBtn];
        
        UIView *botLine = [[UIView alloc] initWithFrame:CGRectMake(20, 59, kScreenWidth - 40, 0.5)];
        
        botLine.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:botLine];
        
    }
    if (indexPath.row == 2) {
        cell.backgroundColor = [UIColor clearColor];
        _loginBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginBtn.titleLabel.textColor  = [UIColor whiteColor];
        [_loginBtn setBackgroundColor:LIVING_COLOR];
        _loginBtn.frame  = CGRectMake(15, 15, kScreenWidth - 30, 45);
        _loginBtn.layer.cornerRadius    = 5.0f;
        _loginBtn.clipsToBounds         = YES;
        
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(submitBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:_loginBtn];
    }
    
    if (indexPath.row == 3) {
        cell.backgroundColor = [UIColor clearColor];
        _loginBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.titleLabel.textColor  = [UIColor whiteColor];
        [_loginBtn setBackgroundColor:LIVING_COLOR];
        _loginBtn.frame  = CGRectMake(15, 15, kScreenWidth - 30, 45);
        _loginBtn.layer.cornerRadius    = 5.0f;
        _loginBtn.clipsToBounds         = YES;
        
        [_loginBtn setTitle:@"微信授权登陆" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(wxinLoginAction) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:_loginBtn];
    }
    
    return cell;
}

#pragma mark 验证码60s倒计时

- (void)timeFireMethod
{
    codeBtn.font                  = [UIFont systemFontOfSize:13];
    codeBtn.text                  = [NSString stringWithFormat:@"%ds后重新发送",_number--];
    
    if (_number == 0)
    {
        [_timer invalidate];
        codeBtn.userInteractionEnabled = YES;
        codeBtn.text        = @"发送验证码";
        codeBtn.font        = TEXT_FONT_LEVEL_1;
        _number             = 60;
    }
}

#pragma mark 获取验证码按钮执行函数

- (void)loginBtnPressed
{
    //  手机号正则
    NSString *mobileRegex = @"[1][34578][0-9]{9}";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    if (!_phoneTF.text || ![mobilePredicate evaluateWithObject:_phoneTF.text]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![CheckUtils isLink]) {
        
        [self textStateHUD:@"无网络连接"];
        return;
    }
    
    [self initStateHud];
    
    LMGetCaptchaRequest   *request    = [[LMGetCaptchaRequest alloc] initWithPhone:_phoneTF.text];
    
    HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                           completed:^(NSString *resp, NSStringEncoding encoding) {
                                               
                                               [self performSelectorOnMainThread:@selector(parseResponse:)
                                                                      withObject:resp
                                                                   waitUntilDone:YES];
                                           } failed:^(NSError *error) {
                                               
                                               [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                      withObject:@"网络错误"
                                                                   waitUntilDone:YES];
                                           }];
    [proxy start];
}

#pragma mark  获取验证码响应方法

- (void)parseResponse:(NSString *)resp
{
    NSDictionary    *bodyDict   = [VOUtil parseBody:resp];
    
    if (!bodyDict) {
        [self textStateHUD:@"获取验证码失败"];
        return;
    }
    
    NSString *result    = [bodyDict objectForKey:@"result"];
    
    if (result && [result intValue] == 0) {
        
        [self textStateHUD:@"验证码已发送"];
        
        //    倒计时60秒 同时 发送验证码按钮失去响应
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(timeFireMethod)
                                                 userInfo:nil
                                                  repeats:YES];
        
        codeBtn.userInteractionEnabled      = NO ;
        
        [_codeTF becomeFirstResponder];
        
    } else {
        
        if ([bodyDict objectForKey:@"description"] && [[bodyDict objectForKey:@"description"] isKindOfClass:[NSString class]]) {
            
            [self textStateHUD:[bodyDict objectForKey:@"description"]];
        } else {
            [self textStateHUD:@"获取验证码失败"];
        }
    }
}

#pragma mark 立即登录按钮执行函数

- (void)submitBtnPressed
{
    //      验证码正则
    NSString    *verCodeRegex     = @"[0-9]{6}";
    NSPredicate *verCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verCodeRegex];
    
    _password   = [self generatePassword:_phoneTF.text];
    
    if (!_codeTF.text || ![verCodePredicate evaluateWithObject:_codeTF.text]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误"
                                                        message:@"验证码为六位数字"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [self initStateHud];
    
    LMloginRequest *request    = [[LMloginRequest alloc] initWithPhone:_phoneTF.text andPassword:_password andCaptcha:_codeTF.text];
    
    HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                           completed:^(NSString *resp, NSStringEncoding encoding) {
                                               
                                               [self performSelectorOnMainThread:@selector(parseCodeResponse:)
                                                                      withObject:resp
                                                                   waitUntilDone:YES];
                                           } failed:^(NSError *error) {
                                               
                                               [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                      withObject:@"网络错误"
                                                                   waitUntilDone:YES];
                                           }];
    [proxy start];
}

#pragma mark 立即登录按钮的响应函数

- (void)parseCodeResponse:(NSString *)resp
{
    [self hideStateHud];
    NSDictionary    *bodyDict   = [VOUtil parseBody:resp];
    
    if (!bodyDict) {
        [self textStateHUD:@"登录失败"];
        return;
    }
    
    NSString *result    = [bodyDict objectForKey:@"result"];
    
    if (result && [result intValue] == 0)
    {
        
        _uuid       = [bodyDict objectForKey:@"user_uuid"];
        
        
        NSString *is_exist = [bodyDict objectForKey:@"has_profile"];
         privileges = [bodyDict objectForKey:@"privileges"];
        
        
        franchisee = [bodyDict objectForKey:@"franchisee"];
        vipString =[bodyDict objectForKey:@"sign"];

        [self setUserInfo];
        
        if (is_exist && [is_exist intValue] == 0) {
            
            LMRegisterViewController *registerVC = [[LMRegisterViewController alloc] init];
            
            registerVC.userId = _uuid;
            registerVC.passWord = _password;
            registerVC.numberString = _phoneTF.text;
           
            [self.navigationController pushViewController:registerVC animated:YES];
        }else{
                    
            [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        
        NSString *string = [bodyDict objectForKey:@"description"];
        [self textStateHUD:string];
    }
}

#pragma mark  密码生成方法

- (NSString *)generatePassword:(NSString *)phone
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD hh:ii:ss"];
    NSString    *password   = [NSString stringWithFormat:@"%@%@%@", [formatter stringFromDate:[NSDate date]], phone, TOKEN];
    return password.md5;
}

#pragma mark 登记用户信息

- (void)setUserInfo{
    NSMutableDictionary *userInfo   = [NSMutableDictionary new];
    
    if (_uuid) {
        [userInfo setObject:_uuid forKey:@"uuid"];
    }
    if (privileges) {
        [userInfo setObject:privileges forKey:@"privileges"];
    }
    
    if (_phoneTF.text) {
        [userInfo setObject:_phoneTF.text forKey:@"phone"];
    }
    
    if (_password) {
        [userInfo setObject:_password forKey:@"password"];
    }
    
    if (franchisee) {
        [userInfo setObject:franchisee forKey:@"franchisee"];
    }
    
    if (vipString) {
        [userInfo setObject:vipString forKey:@"vipString"];
    }
    
    [[FitUserManager sharedUserManager] updateUserInfo:userInfo];
}

#pragma mark 隐私条款执行方法

- (void)lookProtocol
{
    LMWebViewController *webVC = [[LMWebViewController alloc] init];
    
    webVC.urlString = @"http://120.26.64.40:8080/living/user-cn.html";
    webVC.titleString = @"隐私协议";
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark --微信授权登陆

-(void)wxinLoginAction
{
    NSLog(@"**登陆**");
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;//获取用户个人信息字段
    req.state = @"wx" ;
    [WXApi sendReq:req];
}

#pragma mark 微信授权后登录

- (void)wxAgreeAction:(NSDictionary *)dic code:(NSString *)code
{
    [self initStateHud];
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD hh:ii:ss"];
    NSString    *password   = [NSString stringWithFormat:@"%@%@%@", [formatter stringFromDate:[NSDate date]], code, TOKEN];
    
    LMWXLoginRequest *request = [[LMWXLoginRequest alloc] initWithWechatResult:dic andPassword:password];
    
    HTTPProxy *proxy  = [HTTPProxy loadWithRequest:request
                                         completed:^(NSString *resp, NSStringEncoding encoding) {
                                             
                                             [self performSelectorOnMainThread:@selector(wxAgreeActionResponse:)
                                                                    withObject:resp
                                                                 waitUntilDone:YES];
                                         } failed:^(NSError *error) {
                                             
                                             [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                    withObject:@"授权登录失败"
                                                                 waitUntilDone:YES];
                                         }];
    [proxy start];
}

#pragma mark - WXApiManagerDelegate

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:0];
    
    if (response.code) {
        [dict setObject:response.code forKey:@"code"];
    }
    
    [dict setObject:@(response.errCode) forKey:@"errCode"];
    
    if (response.country) {
        [dict setObject:response.country forKey:@"country"];
    }else{
        [dict setObject:@"中国" forKey:@"country"];
    }
    
    if (response.lang) {
        [dict setObject:response.lang forKey:@"lang"];
    }else{
        [dict setObject:@"zh-CN" forKey:@"lang"];
    }
    if (response.state) {
        [dict setObject:response.state forKey:@"state"];
    }
    
    if (response.code&&response.errCode==0) {
        [self wxAgreeAction:dict code:response.code];
    }else{
        [self textStateHUD:@"微信授权失败"];
    }
    NSLog(@"=微信授权登录=dict=======%@",dict);
}

#pragma mark 立即登录按钮的响应函数

- (void)wxAgreeActionResponse:(NSString *)resp
{
    NSDictionary    *bodyDict   = [VOUtil parseBody:resp];
    
    if (!bodyDict) {
        [self textStateHUD:@"授权登录失败"];
        return;
    }
    
    NSLog(@"====微信授权===登录bodyDict=======%@",bodyDict);
    
    NSString *result    = [bodyDict objectForKey:@"result"];
    
    if (result && [result intValue] == 0)
    {
        [self hideStateHud];
        
        _uuid = [bodyDict objectForKey:@"accountID"];
        
        [self setUserInfo];
        
//        if ([bodyDict[@"status"] isEqualToString:@"yes"]) {
//            
//            [self gotoHomepage];
//            
//        }else{
//            
//            CncpPhoneLoginController *phoneVC=[[CncpPhoneLoginController alloc]init];
//            phoneVC.type=@"weixin";
//            [self.navigationController pushViewController:phoneVC animated:YES];
//        }
    }
    
    [self textStateHUD:bodyDict[@"description"]];
}


@end
