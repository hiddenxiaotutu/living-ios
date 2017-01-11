//
//  ChattingCell.m
//  living
//
//  Created by JamHonyZ on 2016/12/13.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "ChattingCell.h"
#import "FitConsts.h"
#import "UIImageView+WebCache.h"

#define lightRedColor [UIColor colorWithRed:255/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]
#define LMRedColor [UIColor colorWithRed:255/255.0f green:84/255.0f blue:84/255.0f alpha:1.0f]
#define LMBuleColor [UIColor colorWithRed:240/255.0f green:248/255.0f blue:255/255.0f alpha:1.0f]
#define lightBuleColor [UIColor colorWithRed:55/255.0f green:155/255.0f blue:239/255.0f alpha:1.0f]
#define LMGrayColor [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0f]
#define LMlightGrayColor [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f]

@implementation ChattingCell
{
    UIView *contentbgView;
    UIImageView *publishImageV;
    UIButton *endButton;
    NSInteger roleNum;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"chatCell";
    
    ChattingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[ChattingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self contentWithCell];
    }
    return self;
}

-(void)contentWithCell
{
    //头像
    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
    [_headImageView setBackgroundColor:[UIColor lightGrayColor]];
    [_headImageView.layer setCornerRadius:5.0f];
    [_headImageView.layer setMasksToBounds:YES];
    [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_headImageView setClipsToBounds:YES];
    [self addSubview:_headImageView];
    
    //名字
    _chatNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 5, kScreenWidth-75, 30)];
    [_chatNameLabel setFont:TEXT_FONT_LEVEL_2];
    [_chatNameLabel setTextColor:[UIColor blackColor]];
    [self addSubview:_chatNameLabel];
    
    //时间
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, kScreenWidth-75, 30)];
    [_timeLabel setTextAlignment:NSTextAlignmentRight];
    [_timeLabel setFont:TEXT_FONT_LEVEL_3];
    [_timeLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_timeLabel];
    
    //声音
    _soundbutton=[[UIButton alloc]initWithFrame:CGRectMake(55, 35, kScreenWidth-70, 35)];
    [_soundbutton.layer setBorderWidth:0.5f];
    [_soundbutton.titleLabel setFont:TEXT_FONT_LEVEL_2];
    [_soundbutton.layer setCornerRadius:3.0f];
    [_soundbutton.layer setMasksToBounds:YES];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTouchedLongTime:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [_soundbutton  addGestureRecognizer:longPress];
    
    [_soundbutton addTarget:self action:@selector(soundPlay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_soundbutton];
    
    
//    _changeTextLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 75, kScreenWidth-70, 50)];
//    [_changeTextLabel.layer setBorderWidth:0.5f];
//    [_changeTextLabel.layer setCornerRadius:3.0f];
//    [_changeTextLabel.layer setMasksToBounds:YES];
//    _changeTextLabel.text = @"...........hwrbgw";
//    [self addSubview:_changeTextLabel];
    
    [self addSubview:contentbgView];
    
    _animalImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8+5, 11, 17)];
    [_soundbutton addSubview:_animalImage];
    
    _duration=[[UILabel alloc]initWithFrame:CGRectMake(_soundbutton.bounds.size.width-60, 0, 50, _soundbutton.bounds.size.height)];
    [_duration setFont:TEXT_FONT_LEVEL_3];
    _duration.textAlignment = NSTextAlignmentRight;
    [_duration setTextColor:[UIColor redColor]];
    [_soundbutton addSubview:_duration];
    
    
    _bootomView = [[UIImageView alloc] init];
//    _bootomView.layer.cornerRadius = 2.5;
//    _bootomView.layer.masksToBounds = YES;
//    _bootomView.clipsToBounds =YES;
//    _bootomView.backgroundColor = [UIColor redColor];
    [self addSubview:_bootomView];
    
    //内容底板
    contentbgView=[[UIView alloc]initWithFrame:CGRectMake(55, 35, kScreenWidth-70, 100)];
    [contentbgView.layer setBorderWidth:0.5f];
    [contentbgView.layer setCornerRadius:3.0f];
    [contentbgView.layer setMasksToBounds:YES];
    
    
    [self addSubview:contentbgView];
    //内容
    _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-70-10, 100)];
    [_contentLabel setText:@" "];
    [_contentLabel setFont:TEXT_FONT_LEVEL_2];
    [_contentLabel setNumberOfLines:0];
    
    [contentbgView addSubview:_contentLabel];
    
    publishImageV=[[UIImageView alloc]initWithFrame:CGRectMake(50, 36, 100, 150)];
    [publishImageV setContentMode:UIViewContentModeScaleAspectFill];
    [publishImageV.layer setCornerRadius:3.0f];
    [publishImageV.layer setMasksToBounds:YES];
    [publishImageV setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:publishImageV];
    
    endButton =[[UIButton alloc]initWithFrame:CGRectMake(55, 35, kScreenWidth-65, 35)];
    [endButton setHidden:YES];
    [self addSubview:endButton];
    
}

-(void)setCellValue:(MssageVO *)vo role:(NSString *)role
{
   
    if (vo.role&&[vo.role isEqualToString:@"teacher"]) {
        [contentbgView.layer setBorderColor:LMRedColor.CGColor];
        [contentbgView setBackgroundColor:lightRedColor];
        [_soundbutton setBackgroundColor:lightRedColor];
        [_soundbutton.layer setBorderColor:LMRedColor.CGColor];
        _animalImage.image = [UIImage imageNamed:@"Image-3"] ;
        roleNum = 1;
    }
    if (vo.role&&[vo.role isEqualToString:@"host"]) {
        [contentbgView.layer setBorderColor:lightBuleColor.CGColor];
        [contentbgView setBackgroundColor:LMBuleColor];
        [_soundbutton setBackgroundColor:LMBuleColor];
        [_soundbutton.layer setBorderColor:lightBuleColor.CGColor];
        _animalImage.image = [UIImage imageNamed:@"Image-13"] ;
        roleNum = 2;
    }
    if (vo.role&&[vo.role isEqualToString:@"student"]) {
        [contentbgView.layer setBorderColor:LMGrayColor.CGColor];
        [contentbgView setBackgroundColor:LMlightGrayColor];
        [_soundbutton setBackgroundColor:LMlightGrayColor];
        [_soundbutton.layer setBorderColor:LMGrayColor.CGColor];
        _animalImage.image = [UIImage imageNamed:@"Image-23"] ;
        roleNum = 3;
    }
    
    if (roleNum ==1) {
        UIImage *image1 = [UIImage imageNamed:@"Image-1"];
        UIImage *image2 = [UIImage imageNamed:@"Image-2"];
        UIImage *image3 = [UIImage imageNamed:@"Image-3"];
        _animalImage.highlightedAnimationImages = @[image1,image2,image3];
    }
    if (roleNum ==2) {
        UIImage *image1 = [UIImage imageNamed:@"Image-11"];
        UIImage *image2 = [UIImage imageNamed:@"Image-12"];
        UIImage *image3 = [UIImage imageNamed:@"Image-13"];
        _animalImage.highlightedAnimationImages = @[image1,image2,image3];
    }
    if (roleNum ==3) {
        UIImage *image1 = [UIImage imageNamed:@"Image-21"];
        UIImage *image2 = [UIImage imageNamed:@"Image-22"];
        UIImage *image3 = [UIImage imageNamed:@"Image-23"];
        _animalImage.highlightedAnimationImages = @[image1,image2,image3];
    }
    
    
    _animalImage.animationDuration = 1.5f;
    _animalImage.animationRepeatCount = NSUIntegerMax;
    if (vo.ifStopAnimal==NO) {
       [_animalImage startAnimating];
    }else{
    
        [_animalImage stopAnimating];
    }  
    //设置时间
    _timeLabel.text = [self getUTCFormateDate:vo.time];
    
    _chatNameLabel.text = vo.name;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:vo.headimgurl]];
    
     //设置内容
    
    //如果为文字
    if (vo.type&&([vo.type isEqual:@"chat"]||[vo.type isEqual:@"question"])) {
        
        NSLog(@"%@",vo.content);
        
        NSString *contentStr=vo.content;
        CGSize contenSize = CGSizeZero;
        if (vo.content) {
            
            
            [_contentLabel setText:contentStr];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentStr];
            
            [paragraphStyle setLineSpacing:2];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentStr.length)];
            
            _contentLabel.attributedText = attributedString;
                    contenSize = [contentStr boundingRectWithSize:CGSizeMake(kScreenWidth-90, MAXFLOAT)                                           options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TEXT_FONT_LEVEL_2,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
        }else{
            [_contentLabel setText:@" "];
        }

        if ([vo.type isEqualToString:@"question"]) {
            
            if (![role isEqualToString:@"student"]) {
                if ([vo.status isEqualToString:@"closed"]) {
                    [endButton setImage:[UIImage imageNamed:@"endRedIcon"] forState:UIControlStateNormal];
                    endButton.userInteractionEnabled = NO;
                    
                }else{
                    [endButton setImage:[UIImage imageNamed:@"endGrayIcon"] forState:UIControlStateNormal];
                    [endButton addTarget:self action:@selector(endQuestion) forControlEvents:UIControlEventTouchUpInside];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endQuestion)];
                    [contentbgView addGestureRecognizer:tap];
                }

            }else{
                if ([vo.status isEqualToString:@"closed"]) {
                    [endButton setImage:[UIImage imageNamed:@"endRedIcon"] forState:UIControlStateNormal];
                    endButton.userInteractionEnabled = NO;
                    
                }else{
                    [endButton setImage:[UIImage imageNamed:@"endGrayIcon"] forState:UIControlStateNormal];
                    [endButton addTarget:self action:@selector(endQuestion) forControlEvents:UIControlEventTouchUpInside];
                    endButton.userInteractionEnabled = NO;
                }
 
            }
            [endButton setHidden:NO];
            [endButton sizeToFit];
            endButton.frame = CGRectMake(kScreenWidth-10-10-20, 35+contenSize.height+10+10+15-20, 20, 20);

            [contentbgView setFrame:CGRectMake(55, 37, kScreenWidth-70, contenSize.height+10+10+15)];
            [_contentLabel setFont:TEXT_FONT_LEVEL_2];
            [_contentLabel setFrame:CGRectMake(10, 10, kScreenWidth-70-10-10, contenSize.height+15)];

            
        }else{
            [endButton setHidden:YES];
            [contentbgView setFrame:CGRectMake(55, 37, kScreenWidth-65, contenSize.height+10+10)];
            [_contentLabel setFont:TEXT_FONT_LEVEL_2];
            [_contentLabel setFrame:CGRectMake(10, 10, kScreenWidth-65-10-10, contenSize.height)];
        }
        
        //显示文字显示控件
        [contentbgView setHidden:NO];
        //隐藏图片显示控件
        [publishImageV setHidden:YES];
        [_bootomView setHidden:YES];
        
        [_soundbutton setHidden:YES];
//        [_changeTextLabel setHidden:YES];
    }
    
    //如果为图片
     if (vo.type&&[vo.type isEqual:@"picture"]) {
         
         [publishImageV sd_setImageWithURL:[NSURL URLWithString:vo.imageurl]];
        
         //隐藏文字显示控件
         [contentbgView setHidden:YES];
         //显示图片显示控件
         [publishImageV setHidden:NO];
         
         [_soundbutton setHidden:YES];
         publishImageV.userInteractionEnabled = YES;
         [_bootomView setHidden:YES];
         [endButton setHidden:YES];
//         [_changeTextLabel setHidden:YES];
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
         [publishImageV addGestureRecognizer:tap];
         
     }
    
    //如果为语音
    if (vo.type&&[vo.type isEqual:@"voice"]) {
        int value = 0;
        if (vo.recordingTime&&![vo.recordingTime isEqual:@""]) {
            value =[vo.recordingTime intValue];
            if (value<15) {
                value = 15;
            }
            if (value>60) {
                value = 60;
            }
            
        }
        [_soundbutton sizeToFit];
        
        [_soundbutton setFrame:CGRectMake(55, 37, (kScreenWidth-70)*value/60, 30+10)];
        [_bootomView sizeToFit];
        [_bootomView setFrame:CGRectMake((NSInteger)_soundbutton.bounds.size.width+3+55, 35, 5, 5)];
        _bootomView.layer.cornerRadius = 2.5;
        _bootomView.clipsToBounds =YES;
        _bootomView.backgroundColor = [UIColor redColor];


        NSMutableArray *urlArray = [NSMutableArray new];
        NSArray *palyArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"readStatus"];
        for (NSDictionary *dic in palyArray) {
            [urlArray addObject:dic[@"url"]];
            
        }
        
        if ([urlArray containsObject:vo.voiceurl]) {
            [_bootomView setHidden:YES];
        }else{
            [_bootomView setHidden:NO];
        }
        
        

        if (vo.recordingTime&&![vo.recordingTime isEqual:@""]) {
           _duration.text  = [NSString stringWithFormat:@"%@''",vo.recordingTime];
         _duration.frame=CGRectMake(_soundbutton.bounds.size.width-60, 0, 50, _soundbutton.bounds.size.height);
        }

        //显示文字显示控件
        [contentbgView setHidden:YES];
        //隐藏图片显示控件
        [publishImageV setHidden:YES];
        
        [_soundbutton setHidden:NO];
        [endButton setHidden:YES];
//        [_changeTextLabel setHidden:YES];
    }
   
}


- (void)soundPlay
{
    if ([_delegate respondsToSelector:@selector(cellClickVoice:)]) {
        
        [_delegate cellClickVoice:self];

    }
}

- (void)imageClick
{
    if ([_delegate respondsToSelector:@selector(cellClickImage:)]) {
        [_delegate cellClickImage:self];
    }
}

- (void)endQuestion
{
    if ([_delegate respondsToSelector:@selector(cellcloseQuestion:)]) {
        [_delegate cellcloseQuestion:self];
    }
}



- (void)setVoicePlayState:(LGVoicePlayState)voicePlayState {
    if (_voicePlayState != voicePlayState) {
        _voicePlayState = voicePlayState;
    }
    _animalImage.hidden = NO;
    
    if (_voicePlayState == LGVoicePlayStatePlaying) {
        _animalImage.highlighted = YES;
        [_animalImage startAnimating];
        _playStatus = @"play";
    }else if (_voicePlayState == LGVoicePlayStateDownloading) {
        _animalImage.hidden = YES;
    }else {
        _animalImage.highlighted = NO;
        [_animalImage stopAnimating];
        _playStatus = @"stop";
    }
}


-(NSString *)getUTCFormateDate:(NSString *)newDate
{
    NSString *str=[newDate substringWithRange:NSMakeRange(0, 16)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:str];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int day=((int)time)/(3600*24);
    int hour=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent  = nil;
    
    if(month!=0){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日"];
        
        NSString *str= [dateFormatter stringFromDate:newsDateFormatted];
        
        dateContent = str;
    }else if(day!=0){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日"];
        
        NSString *str= [dateFormatter stringFromDate:newsDateFormatted];
        dateContent = str;
    }else if(hour!=0){
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hour,@"小时前"];
    }else if(minute !=0){
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
        
    }else
    {
        dateContent =@"刚刚";
    }
    
    return dateContent;
}


- (void)buttonTouchedLongTime:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
    
    NSLog(@"***********");
    if ([_delegate respondsToSelector:@selector(cellVoiceChangeText:)]) {
//        [_changeTextLabel setHidden:NO];
        [_delegate cellVoiceChangeText:self];
        
    }
    }
    
}







@end
