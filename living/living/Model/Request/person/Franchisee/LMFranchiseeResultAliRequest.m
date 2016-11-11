//
//  LMFranchiseeResultAliRequest.m
//  living
//
//  Created by Ding on 2016/11/11.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMFranchiseeResultAliRequest.h"

@implementation LMFranchiseeResultAliRequest

- (id)initWithMyOrderUuid:(NSString *)myOrderUuid andAlipayResult:(NSDictionary *)alipayResult
{
    self = [super init];
    if (self)
    {
        
        NSMutableDictionary     *bodyDict   = [NSMutableDictionary new];
        
        if (myOrderUuid) {
            [bodyDict setObject:myOrderUuid forKey:@"myOrderUuid"];
        }
        
        if (alipayResult) {
            [bodyDict setObject:alipayResult forKey:@"alipayResult"];
        }
        
        NSMutableDictionary     *paramsDict = [self params];
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
    return @"join/alipay/result";//加盟信息结果确认
}

@end