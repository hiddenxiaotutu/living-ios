
//
//  ActivityListVO.m
//  living
//
//  Created by JamHonyZ on 2016/11/6.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "ActivityListVO.h"

@implementation ActivityListVO

+ (ActivityListVO *)ActivityListVOWithJSONString:(NSString *)jsonString usingEncoding:(NSStringEncoding)stringEncoding error:(NSError **)error
{
    NSData *jsonData = [jsonString dataUsingEncoding:stringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:0
                                                                     error:error];
    
    if (nil != error && nil != jsonDictionary) {
        return [ActivityListVO ActivityListVOWithDictionary:jsonDictionary];
    }
    
    return nil;
}

+ (ActivityListVO *)ActivityListVOWithDictionary:(NSDictionary *)dictionary
{
    ActivityListVO *instance = [[ActivityListVO alloc] initWithDictionary:dictionary];
    return JSONAutoRelease(instance);
}

+ (NSArray *)ActivityListVOListWithArray:(NSArray *)array
{
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (id entry in array) {
        if (![entry isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        [resultsArray addObject:[ActivityListVO ActivityListVOWithDictionary:entry]];
    }
    
    return JSONAutoRelease(resultsArray);
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        if (nil != [dictionary objectForKey:@"nick_name"] && ![[dictionary objectForKey:@"nick_name"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"nick_name"] isKindOfClass:[NSString class]]) {
            self.NickName = [dictionary objectForKey:@"nick_name"];
        }
        
        if (nil != [dictionary objectForKey:@"event_uuid"] && ![[dictionary objectForKey:@"event_uuid"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"event_uuid"] isKindOfClass:[NSString class]]) {
            self.EventUuid = [dictionary objectForKey:@"event_uuid"];
        }
        
        if (nil != [dictionary objectForKey:@"current_num"] && ![[dictionary objectForKey:@"current_num"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"current_num"] isKindOfClass:[NSNumber class]]) {
            self.CurrentNumber = [dictionary objectForKey:@"current_num"];
        }
        
        if (nil != [dictionary objectForKey:@"user_uuid"] && ![[dictionary objectForKey:@"user_uuid"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"user_uuid"] isKindOfClass:[NSString class]]) {
            self.UserUuid = [dictionary objectForKey:@"user_uuid"];
        }
        
        if (nil != [dictionary objectForKey:@"total_num"] && ![[dictionary objectForKey:@"total_num"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"total_num"] isKindOfClass:[NSNumber class]]) {
            self.TotalNumber = [dictionary objectForKey:@"total_num"];
        }
        
        if (nil != [dictionary objectForKey:@"per_cost"] && ![[dictionary objectForKey:@"per_cost"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"per_cost"] isKindOfClass:[NSString class]]) {
            self.PerCost = [dictionary objectForKey:@"per_cost"];
        }
        
        if (nil != [dictionary objectForKey:@"address"] && ![[dictionary objectForKey:@"address"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"address"] isKindOfClass:[NSString class]]) {
            self.Address = [dictionary objectForKey:@"address"];
        }
        
        if (nil != [dictionary objectForKey:@"start_time"] && ![[dictionary objectForKey:@"start_time"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"start_time"] isKindOfClass:[NSString class]]) {
            
            NSDateFormatter     *formatter  = [[NSDateFormatter alloc] init];
            
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            self.StartTime = [formatter dateFromString:[dictionary objectForKey:@"start_time"]];
        }
        
        if (nil != [dictionary objectForKey:@"event_img"] && ![[dictionary objectForKey:@"event_img"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"event_img"] isKindOfClass:[NSString class]]) {
            self.EventImg = [dictionary objectForKey:@"event_img"];
        }
        
        if (nil != [dictionary objectForKey:@"avatar"] && ![[dictionary objectForKey:@"avatar"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"avatar"] isKindOfClass:[NSString class]]) {
            self.Avatar = [dictionary objectForKey:@"avatar"];
        }
        
        if (nil != [dictionary objectForKey:@"event_name"] && ![[dictionary objectForKey:@"event_name"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"event_name"] isKindOfClass:[NSString class]]) {
            self.EventName = [dictionary objectForKey:@"event_name"];
        }
        
        if (nil != [dictionary objectForKey:@"status"] && ![[dictionary objectForKey:@"status"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"status"] isKindOfClass:[NSString class]]) {
            self.Status = [dictionary objectForKey:@"status"];
        }
    }
    
    return self;
}

@end