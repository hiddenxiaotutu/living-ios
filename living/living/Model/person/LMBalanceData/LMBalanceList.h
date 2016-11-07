//
//  LMBalanceList.h
//
//  Created by   on 2016/11/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LMBalanceList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *monthofbalance;
@property (nonatomic, strong) NSString *month;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
