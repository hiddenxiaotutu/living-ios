//
//  LMBalanceChargeRequest.m
//  living
//
//  Created by Ding on 2016/11/8.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMBalanceChargeRequest.h"

@implementation LMBalanceChargeRequest

-(id)initWithOrder_uuid:(NSString *)order_uuid useBalance:(NSString *)useBalance
{
    self = [super init];
    
    if (self){
        
        NSMutableDictionary *bodyDict   = [NSMutableDictionary new];
        
        if (order_uuid){
            [bodyDict setObject:order_uuid forKey:@"order_uuid"];
        }
        
        if (useBalance){
            [bodyDict setObject:useBalance forKey:@"useBalance"];
        }
        
        
        
        NSMutableDictionary *paramsDict = [self params];
        [paramsDict setObject:bodyDict forKey:@"body"];
    }
    return self;
}

- (BOOL)isPost
{
    return YES;
}

- (NSString *)methodPath
{
    return @"balance/payment";
}

@end
