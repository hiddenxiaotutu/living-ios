//
//  LMEventMsgCell.h
//  living
//
//  Created by Ding on 16/10/13.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMEventDetailLeavingMessages.h"

@interface LMEventMsgCell : UITableViewCell

@property (nonatomic)CGFloat conHigh;

@property (nonatomic, readonly) float xScale;
@property (nonatomic, readonly) float yScale;

- (void)setXScale:(float)xScale yScale:(float)yScale;

-(void)setValue:(LMEventDetailLeavingMessages *)data;

+ (CGFloat)cellHigth:(NSString *)titleString;

@end
