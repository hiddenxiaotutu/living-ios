//
//  LMEvaluateStarView.m
//  living
//
//  Created by WangShengquan on 2017/2/24.
//  Copyright © 2017年 chenle. All rights reserved.
//

#import "LMEvaluateStarView.h"

@interface LMEvaluateStarView ()
{
    //星星总个数
    NSInteger totalNumber;
    
    //单个代表的评分
    CGFloat singlePoint;
    
    //最大分数
    NSInteger maxPoints;
    
    //星星的tag
    NSInteger starBaseTag;
    
    //填充的视图
    UIView *starView;
    
    //填充星星的偏移量
    CGFloat starOffset;
}

@end

@implementation LMEvaluateStarView

-(instancetype)initWithFrame:(CGRect)frame withTotalStar:(NSInteger)totalStar withTotalPoint:(CGFloat)totalPoint starSpace:(NSInteger)space
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //对传进来的frame进行处理，取合适的星星的高度
        
        //传进来的高度
        CGFloat height = frame.size.height;
        //减去间距后的平均的宽度（我设置的星星 高度＝宽度）
        CGFloat averageHeight = (frame.size.width-space*(totalStar-1))/totalStar;
        
        if (height>averageHeight) {
            _starHeight = averageHeight;
        }else{
            _starHeight = height;
        }
        
        starBaseTag = 6666;
        _spaceWidth = space;
        totalNumber = totalStar;
        singlePoint = totalPoint/totalStar;
        maxPoints = totalPoint;
        
        [self loadCustomViewWithTotal:totalStar];
    }
    return self;
}

- (void)loadCustomViewWithTotal:(NSInteger)totalStar
{
    //先铺背景图片（空的星星）
    for (int i =0 ; i<totalStar; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_starHeight+i*_spaceWidth, self.frame.size.height-_starHeight, _starHeight, _starHeight)];
        imageView.tag = starBaseTag+i;
        imageView.image = [UIImage imageNamed:@"Star"];
        [self addSubview:imageView];
    }
    
}

- (void)changeSelectedStarNumWithPoint:(float)point
{
}

//当你设置评分时 开始填充整颗星星
- (void)setCommentPoint:(float)commentPoint
{
    _commentPoint = commentPoint;
    
    if (commentPoint > maxPoints) {
        commentPoint = maxPoints;
    }
    
    CGFloat showNumber = commentPoint/singlePoint;
    
    //覆盖的长图
    if (!starView) {
        starView = [[UIView alloc]init];
    }
    
    starView.frame = CGRectZero;
    //整颗星星
    NSInteger fullNumber = showNumber/1;
    
    if (starOffset > 0) {
        starView.frame = CGRectMake(starOffset, self.frame.size.height-_starHeight, _starHeight*showNumber+_spaceWidth*fullNumber, _starHeight);
        
    }else{
        starView.frame = CGRectMake(0, self.frame.size.height-_starHeight, _starHeight*showNumber+_spaceWidth*fullNumber, _starHeight);
        
    }
    starView.clipsToBounds = YES;
    
    //在长图上填充完整的星星
    for (int j = 0; j< fullNumber; j++) {
        UIImageView *starImageView = [[UIImageView alloc]init];
        starImageView.image = [UIImage imageNamed:@"in"];
        starImageView.frame = CGRectMake(j*_starHeight+j*_spaceWidth, 0, _starHeight, _starHeight);
        [starView addSubview:starImageView];
    }
    
    CGFloat part = showNumber - fullNumber;
    //如果有残缺的星星 则添加
    if (part > 0) {
        UIImageView *partImage = [[UIImageView alloc]initWithFrame:CGRectMake(fullNumber*_starHeight+fullNumber*_spaceWidth, 0, _starHeight, _starHeight)];
        partImage.image = [UIImage imageNamed:@""];
        [starView addSubview:partImage];
    }
    
    [self addSubview:starView];
}

//设置星星的对齐方式
- (void)setStarAliment:(StarAliment)starAliment
{
    _starAliment = starAliment;
    
    switch (starAliment) {
            //居中对齐
        case StarAlimentCenter:
        {
            CGFloat starRealWidth = totalNumber*_starHeight+(totalNumber-1)*_spaceWidth;
            CGFloat leftWidth = self.frame.size.width-starRealWidth;
            
            for (int i =0 ; i< totalNumber; i++) {
                UIImageView *starImageView = (UIImageView*)[self viewWithTag:i+starBaseTag];
                starImageView.frame = CGRectMake(leftWidth/2+starImageView.frame.origin.x, starImageView.frame.origin.y, starImageView.frame.size.width, starImageView.frame.size.height);
            }
            starOffset = leftWidth/2;
            starView.frame = CGRectMake(leftWidth/2+starView.frame.origin.x, starView.frame.origin.y, starView.frame.size.width, starView.frame.size.height);
            
        }
            break;
            //右对齐
        case StarAlimentRight:
        {
            CGFloat starRealWidth = totalNumber*_starHeight+(totalNumber-1)*_spaceWidth;
            CGFloat leftWidth = self.frame.size.width-starRealWidth;
            
            for (int i =0 ; i< totalNumber; i++) {
                UIImageView *starImageView = (UIImageView*)[self viewWithTag:i+starBaseTag];
                starImageView.frame = CGRectMake(leftWidth+starImageView.frame.origin.x, starImageView.frame.origin.y, starImageView.frame.size.width, starImageView.frame.size.height);
            }
            starOffset = leftWidth;
            starView.frame = CGRectMake(leftWidth+starView.frame.origin.x, starView.frame.origin.y, starView.frame.size.width, starView.frame.size.height);
            
        }
            break;
            //默认的左对齐
        case StarAlimentDefault:
        {
            
            for (int i =0 ; i< totalNumber; i++) {
                UIImageView *starImageView = (UIImageView*)[self viewWithTag:i+starBaseTag];
                starImageView.frame = CGRectMake(i*_starHeight+i*_spaceWidth, self.frame.size.height-_starHeight, _starHeight, _starHeight);
            }
            
            
            CGFloat showNumber = self.commentPoint/singlePoint;
            
            //整颗星星
            NSInteger fullNumber = showNumber/1;
            starOffset = 0;
            starView.frame = CGRectMake(0, self.frame.size.height-_starHeight, _starHeight*showNumber+_spaceWidth*fullNumber, _starHeight);
            
        }
            break;
        default:
        {
            
        }
            break;
    }
}

@end
