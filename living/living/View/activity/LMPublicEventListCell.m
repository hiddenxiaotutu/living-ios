//
//  LMPublicEventListCell.m
//  living
//
//  Created by Ding on 16/10/14.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMPublicEventListCell.h"
#import "FitConsts.h"

#define titleW titleLable.bounds.size.width
@implementation LMPublicEventListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self    = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    //活动标题
    UILabel *titleLable = [UILabel new];
    titleLable.text = @"项目标题";
    titleLable.font = TEXT_FONT_LEVEL_1;
    titleLable.textColor = TEXT_COLOR_LEVEL_2;
    [titleLable sizeToFit];
    titleLable.frame = CGRectMake(10, 5, titleLable.bounds.size.width, 30);
    [self.contentView addSubview:titleLable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 40, kScreenWidth-25-titleW, 1.0)];
    lineView.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView];
    
    //项目介绍
    UILabel *phoneLable = [UILabel new];
    phoneLable.text = @"项目介绍";
    phoneLable.font = TEXT_FONT_LEVEL_1;
    phoneLable.textColor = TEXT_COLOR_LEVEL_2;
    [phoneLable sizeToFit];
    phoneLable.frame = CGRectMake(10, 50, titleW, 30);
    [self.contentView addSubview:phoneLable];
    
    //项目图片
    UILabel *imageLable = [UILabel new];
    imageLable.text = @"项目图片";
    imageLable.font = TEXT_FONT_LEVEL_1;
    imageLable.textColor = TEXT_COLOR_LEVEL_2;
    [imageLable sizeToFit];
    imageLable.frame = CGRectMake(10, 210, imageLable.bounds.size.width, 30);
    [self.contentView addSubview:imageLable];
    
    UILabel *imagemsgLable = [UILabel new];
    imagemsgLable.text = @"(建议尺寸：750*330)";
    imagemsgLable.font = TEXT_FONT_LEVEL_3;
    imagemsgLable.textColor = TEXT_COLOR_LEVEL_3;
    [imagemsgLable sizeToFit];
    imagemsgLable.frame = CGRectMake(15+imageLable.bounds.size.width, 210, imagemsgLable.bounds.size.width, 30);
    [self.contentView addSubview:imagemsgLable];
    
    
    _titleTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 5, kScreenWidth- titleW-25, 30)];
    _titleTF.font = TEXT_FONT_LEVEL_2;
    _titleTF.placeholder = @"请输入项目标题";
    [self.contentView addSubview:_titleTF];
    
    
    UIView *TFview = [[UIView alloc] initWithFrame:CGRectMake(titleW+20, 50, kScreenWidth- titleW-30, 160)];
    TFview.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [self.contentView addSubview:TFview];
    
    _includeTF = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth- titleW-35, 160)];
    _includeTF.backgroundColor = [UIColor clearColor];
    _includeTF.font = TEXT_FONT_LEVEL_2;
    
    UILabel *textLab = [UILabel new];
    textLab.text = @"请输入项目详情";
    textLab.textColor = TEXT_COLOR_LEVEL_3;
    textLab.font = TEXT_FONT_LEVEL_2;
    [textLab sizeToFit];
    textLab.frame = CGRectMake(5, 0, textLab.bounds.size.width, 30);
    [_includeTF addSubview:textLab];
    [TFview addSubview:_includeTF];
    
    
    UIView *imgBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 240, 70, 70)];
    imgBackView.layer.borderColor = LINE_COLOR.CGColor;
    imgBackView.layer.borderWidth=0.5;
    [self.contentView addSubview:imgBackView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(25, 23, 20, 22)];
    image.image = [UIImage imageNamed:@"publicProgram"];
    [imgBackView addSubview:image];
    
    
    _eventButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _eventButton.backgroundColor = [UIColor clearColor];
    _eventButton.frame = CGRectMake(0, 0, 70, 70);
    [imgBackView addSubview:_eventButton];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 330, kScreenWidth, 10)];
    footView.backgroundColor = BG_GRAY_COLOR;
    [self.contentView addSubview:footView];
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end