//
//  LMCommentCell.m
//  living
//
//  Created by Ding on 16/9/28.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMCommentCell.h"
#import "FitConsts.h"

@interface LMCommentCell () {
    float _xScale;
    float _yScale;
}

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *lineLabel;


@end

@implementation LMCommentCell

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
    _imageV = [UIImageView new];
    
    _imageV.image = [UIImage imageNamed:@"112"];
    [_imageV sizeToFit];
    _imageV.frame = CGRectMake(15, 15, 30, 30);
     _imageV.layer.cornerRadius =15;
    [_imageV setClipsToBounds:YES];
    _imageV.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_imageV];
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"评论者名字";
    _nameLabel.font = [UIFont systemFontOfSize:12.f];
    _nameLabel.textColor = TEXT_COLOR_LEVEL_3;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2016-09-12 18:26";
    _timeLabel.font = [UIFont systemFontOfSize:12.f];
    _timeLabel.textColor = TEXT_COLOR_LEVEL_3;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [UILabel new];
//    _titleLabel.text = @"果然我问问我吩咐我跟我玩嗡嗡图文无关的身份和她和热稳定";
    _titleLabel.numberOfLines  = 0;
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.textColor = TEXT_COLOR_LEVEL_2;
    [self.contentView addSubview:_titleLabel];
    
    
    _addressLabel = [UILabel new];
    _addressLabel.text = @"浙江杭州";
    _addressLabel.font = [UIFont systemFontOfSize:12.f];
    _addressLabel.textColor = TEXT_COLOR_LEVEL_2;
    [self.contentView addSubview:_addressLabel];
    
    _lineLabel = [UILabel new];
    _lineLabel.backgroundColor =LINE_COLOR;
    [self.contentView addSubview:_lineLabel];
    
    
}


-(void)setTitleString:(NSString *)titleString
{
    _titleLabel.text = titleString;
    

    //指定自适应过程中自适应的字体
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    //参数1 代表文字自适应的范围 2代表 文字自适应的方式前三种 3代表文字在自适应过程中自适应的字体大小
//   NSString *string =@"果然我问问我吩咐我跟我玩嗡嗡图文无关的身份和她和热稳定";
    _conHigh = [titleString boundingRectWithSize:CGSizeMake(kScreenWidth-70, 100000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;

    
    
    
}

-(void)setData:(NSString *)data
{
    
}


- (void)setXScale:(float)xScale yScale:(float)yScale
{
    _xScale = xScale;
    _yScale = yScale;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_nameLabel sizeToFit];
    
    [_titleLabel sizeToFit];
    [_timeLabel sizeToFit];
    [_addressLabel sizeToFit];
    
    
    _nameLabel.frame = CGRectMake(55, 15, _nameLabel.bounds.size.width, 20);
    
    _timeLabel.frame = CGRectMake(55, 35, _timeLabel.bounds.size.width, _timeLabel.bounds.size.height);
    _titleLabel.frame = CGRectMake(55, 60, kScreenWidth-70, _conHigh);
    _addressLabel.frame =CGRectMake(55,70+_conHigh, _addressLabel.bounds.size.width, _addressLabel.bounds.size.height);
    
    _lineLabel.frame = CGRectMake(15, 75+_conHigh+20, kScreenWidth-30, 0.5);
    
    
    
}

+ (CGFloat)cellHigth:(NSString *)titleString
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat conHigh = [titleString boundingRectWithSize:CGSizeMake(kScreenWidth-70, 100000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
    return (75+conHigh+20);
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