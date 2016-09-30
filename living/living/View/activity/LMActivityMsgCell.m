//
//  LMActivityMsgCell.m
//  living
//
//  Created by Ding on 16/9/30.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMActivityMsgCell.h"
#import "FitConsts.h"

@interface LMActivityMsgCell () {
    float _xScale;
    float _yScale;
}

@property (nonatomic, strong) UIImageView *phoneV;
@property (nonatomic, strong) UIImageView *timeV;
@property (nonatomic, strong) UIImageView *addressV;
@property (nonatomic, strong) UIImageView *freeV;


@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation LMActivityMsgCell

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
    
    //号码
    
    _phoneV = [UIImageView new];
    _phoneV.image = [UIImage imageNamed:@"phoneV"];
    [self.contentView addSubview:_phoneV];
    
    
    _numberLabel = [UILabel new];
    _numberLabel.text = @"15878901234(老王)";
    _numberLabel.font = [UIFont systemFontOfSize:14.f];
    _numberLabel.textColor = TEXT_COLOR_LEVEL_2;
    [self.contentView addSubview:_numberLabel];
    
    
    //价格
    
    _freeV = [UIImageView new];
    _freeV.image = [UIImage imageNamed:@"freeV"];
    [self.contentView addSubview:_freeV];
    
    _priceLabel = [UILabel new];
    _priceLabel.text = @"人均费用 400 元";
    _priceLabel.font = [UIFont systemFontOfSize:14.f];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = TEXT_COLOR_LEVEL_2;
    [self.contentView addSubview:_priceLabel];
    
    
    
    //活动时间
    
    _timeV = [UIImageView new];
    _timeV.image = [UIImage imageNamed:@"timeV"];
    [self.contentView addSubview:_timeV];
    
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2016-10-1 12:20 —— 2016-12-03 13:00";
    _timeLabel.font = [UIFont systemFontOfSize:14.f];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = TEXT_COLOR_LEVEL_2;
    [self.contentView addSubview:_timeLabel];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, kScreenWidth, 30)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:footView];
    
    
    //活动地址
    
    _addressV = [UIImageView new];
    _addressV.image = [UIImage imageNamed:@"addressV"];
    [self.contentView addSubview:_addressV];
    
    
    _addressLabel = [UILabel new];
    _addressLabel.text = @"浙江省杭州市西湖区万塘路";
    _addressLabel.textAlignment = NSTextAlignmentRight;
    _addressLabel.font = [UIFont systemFontOfSize:13.f];
    _addressLabel.textColor = TEXT_COLOR_LEVEL_2;
    [self.contentView addSubview:_addressLabel];
    
    
    
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
    [_phoneV sizeToFit];
    [_timeV sizeToFit];
    [_addressV sizeToFit];
    [_freeV sizeToFit];

    [_timeLabel sizeToFit];
    [_numberLabel sizeToFit];
    [_priceLabel sizeToFit];
    [_addressLabel sizeToFit];
 
    _phoneV.frame = CGRectMake(15, 15, 24, 20);
    _freeV.frame = CGRectMake(15, 118, 20, 24);
    _timeV.frame = CGRectMake(15, 48, 22, 24);
    _addressV.frame = CGRectMake(15, 86, 24, 18);

    
    _numberLabel.frame = CGRectMake(40, 10, kScreenWidth-30, 30);
    _priceLabel.frame = CGRectMake(40, 115, _priceLabel.bounds.size.width, 30);
    _timeLabel.frame = CGRectMake(40, 45, _timeLabel.bounds.size.width, 30);
    
    _addressLabel.frame = CGRectMake(40, 80, _addressLabel.bounds.size.width, 30);
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