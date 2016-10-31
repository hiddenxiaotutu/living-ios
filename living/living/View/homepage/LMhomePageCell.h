//
//  LMhomePageCell.h
//  living
//
//  Created by Ding on 16/9/26.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMActicleList.h"

@protocol  LMhomePageCellDelegate;

@interface LMhomePageCell : UITableViewCell
@property (nonatomic, strong)NSString *imageUrl;

@property (nonatomic, weak) id <LMhomePageCellDelegate> delegate;

-(void)setValue:(LMActicleList *)list;

@end


@protocol LMhomePageCellDelegate <NSObject>

@optional
- (void)cellWillClick:(LMhomePageCell *)cell;

@end
