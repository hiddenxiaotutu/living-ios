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

@implementation ChattingCell
{
    UIView *contentbgView;
    UIImageView *publishImageV;
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
    _chatNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, kScreenWidth-75, 30)];
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
//    _soundbutton=[[UIButton alloc]initWithFrame:CGRectMake(50, 35, kScreenWidth-65, 35)];
//    [_soundbutton.layer setBorderWidth:0.5f];
//    [_soundbutton.titleLabel setFont:TEXT_FONT_LEVEL_2];
//    [_soundbutton.layer setCornerRadius:3.0f];
//    [_soundbutton.layer setMasksToBounds:YES];
//    [_soundbutton setBackgroundColor:lightRedColor];
//    [_soundbutton.layer setBorderColor:[UIColor redColor].CGColor];
//    [self addSubview:_soundbutton];
//    
//    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8.5, 11, 17)];
//    [imageV setImage:[UIImage imageNamed:@"cellSoundIcon"]];
//    [_soundbutton addSubview:imageV];
//    
//    _duration=[[UILabel alloc]initWithFrame:CGRectMake(_soundbutton.bounds.size.width-20, 0, 20, _soundbutton.bounds.size.height)];
//    [_duration setText:@"8”"];
//    [_duration setFont:TEXT_FONT_LEVEL_3];
//    [_duration setTextColor:[UIColor redColor]];
//    [_soundbutton addSubview:_duration];
    
    //内容底板
    contentbgView=[[UIView alloc]initWithFrame:CGRectMake(50, 35, kScreenWidth-65, 100)];
    [contentbgView.layer setBorderWidth:0.5f];
    [contentbgView.layer setCornerRadius:3.0f];
    [contentbgView.layer setMasksToBounds:YES];
    [contentbgView setBackgroundColor:lightRedColor];
    [contentbgView.layer setBorderColor:[UIColor redColor].CGColor];
    [self addSubview:contentbgView];
    //内容
    _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-65-10, 100)];
    [_contentLabel setText:@" "];
    [_contentLabel setFont:TEXT_FONT_LEVEL_2];
    [_contentLabel setNumberOfLines:0];
    [_contentLabel setBackgroundColor:lightRedColor];
    [contentbgView addSubview:_contentLabel];
    
    publishImageV=[[UIImageView alloc]initWithFrame:CGRectMake(50, 35, 100, 150)];
    [publishImageV setContentMode:UIViewContentModeScaleAspectFill];
    [publishImageV.layer setCornerRadius:3.0f];
    [publishImageV.layer setMasksToBounds:YES];
    [publishImageV setBackgroundColor:BG_GRAY_COLOR];
    [self addSubview:publishImageV];
}

-(void)setCellValue:(MssageVO *)vo
{
    //设置时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"MM-dd hh:mm"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
    NSString *currentTime = [formatter stringFromDate:vo.time];
    [_timeLabel setText:currentTime];
    
    _chatNameLabel.text = vo.name;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:vo.headimgurl]];
    
     //设置内容
    
    //如果为文字
    if (vo.type&&[vo.type isEqual:@"chat"]) {
        
        NSString *contentStr=vo.content;
        
         [_contentLabel setText:contentStr];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentStr];
       
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentStr.length)];
        
        _contentLabel.attributedText = attributedString;

        CGSize contenSize = [contentStr boundingRectWithSize:CGSizeMake(kScreenWidth-75, MAXFLOAT)                                           options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TEXT_FONT_LEVEL_2,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
        [contentbgView setFrame:CGRectMake(50, 35, kScreenWidth-65, contenSize.height+10)];
         [_contentLabel setFont:TEXT_FONT_LEVEL_2];
        [_contentLabel setFrame:CGRectMake(5, 5, kScreenWidth-65-10, contenSize.height)];
        
        //显示文字显示控件
        [contentbgView setHidden:NO];
        //隐藏图片显示控件
        [publishImageV setHidden:YES];
    }
    
    //如果为图片
     if (vo.type&&[vo.type isEqual:@"picture"]) {
         
         [publishImageV sd_setImageWithURL:[NSURL URLWithString:vo.imageurl]];
         //隐藏文字显示控件
         [contentbgView setHidden:YES];
         //显示图片显示控件
         [publishImageV setHidden:NO];
     }
   
}

@end