//
//  MssageVO.m
//  living
//
//  Created by Ding on 2016/12/20.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "MssageVO.h"

@implementation MssageVO

+ (MssageVO *)MssageVOWithJSONString:(NSString *)jsonString usingEncoding:(NSStringEncoding)stringEncoding error:(NSError **)error
{
    NSData *jsonData = [jsonString dataUsingEncoding:stringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:0
                                                                     error:error];
    
    if (nil != error && nil != jsonDictionary) {
        return [MssageVO MssageVOWithDictionary:jsonDictionary];
    }
    
    return nil;
}

+ (MssageVO *)MssageVOWithDictionary:(NSDictionary *)dictionary
{
    MssageVO *instance = [[MssageVO alloc] initWithDictionary:dictionary];
    return JSONAutoRelease(instance);
}

+ (NSArray *)MssageVOListWithArray:(NSArray *)array
{
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (id entry in array) {
        if (![entry isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        [resultsArray addObject:[MssageVO MssageVOWithDictionary:entry]];
    }
    
    return JSONAutoRelease(resultsArray);
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        if (nil != [dictionary objectForKey:@"name"] && ![[dictionary objectForKey:@"name"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            self.name = [dictionary objectForKey:@"name"];
        }
        
        if (nil != [dictionary objectForKey:@"content"] && ![[dictionary objectForKey:@"content"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"content"] isKindOfClass:[NSString class]]) {
            self.content = [dictionary objectForKey:@"content"];
        }
        
        if (nil != [dictionary objectForKey:@"type"] && ![[dictionary objectForKey:@"type"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"type"] isKindOfClass:[NSString class]]) {
            self.type = [dictionary objectForKey:@"type"];
        }
        
        if (nil != [dictionary objectForKey:@"time"] && ![[dictionary objectForKey:@"time"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"time"] isKindOfClass:[NSString class]]) {
            
            NSDateFormatter     *formatter  = [[NSDateFormatter alloc] init];
            
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            self.time = [formatter dateFromString:[dictionary objectForKey:@"time"]];
        }
        
        
        if (nil != [dictionary objectForKey:@"role"] && ![[dictionary objectForKey:@"role"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"role"] isKindOfClass:[NSString class]]) {
            self.role = [dictionary objectForKey:@"role"];
        }
        
        if (nil != [dictionary objectForKey:@"headimgurl"] && ![[dictionary objectForKey:@"headimgurl"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"headimgurl"] isKindOfClass:[NSString class]]) {
            self.headimgurl = [dictionary objectForKey:@"headimgurl"];
        }
        
        if (nil != [dictionary objectForKey:@"voiceurl"] && ![[dictionary objectForKey:@"voiceurl"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"voiceurl"] isKindOfClass:[NSString class]]) {
            self.voiceurl = [dictionary objectForKey:@"voiceurl"];
        }
        
        if (nil != [dictionary objectForKey:@"imageurl"] && ![[dictionary objectForKey:@"imageurl"] isEqual:[NSNull null]]
            && [[dictionary objectForKey:@"imageurl"] isKindOfClass:[NSString class]]) {
            self.imageurl = [dictionary objectForKey:@"imageurl"];
        }
        
    }
    
    return self;
}


@end