//
//  LMWXLoginRequest.m
//  living
//
//  Created by Ding on 2016/11/6.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMWXLoginRequest.h"

@implementation LMWXLoginRequest

- (id)initWithWechatResult:(NSDictionary *)dic  andPassword:(NSString *)password{
    
    self = [super init];
    
    if (self) {
        NSMutableDictionary *bodyDict = [NSMutableDictionary new];
        
        if (dic) {
            [bodyDict setObject:dic forKey:@"wechatResult"];
        }
        
        if (password) {
            [bodyDict setObject:password forKey:@"password"];
        }
        
        
        NSMutableDictionary *paramsDict = [self params];
        [paramsDict setObject:bodyDict forKey:@"body"];
    }
    return self;
}

- (BOOL)isPost {
    
    return YES;
}

- (NSString *)methodPath {
    
    return @"wechat/login";
}

@end
