//
//  LMRecommendVO.h
//  living
//
//  Created by hxm on 2017/3/10.
//  Copyright © 2017年 chenle. All rights reserved.
//

#import <Foundation/Foundation.h>
#if ! __has_feature(objc_arc)
#define JSONAutoRelease(param) ([param autorelease]);
#else
#define JSONAutoRelease(param) (param)
#endif
@interface LMRecommendVO : NSObject

+ (LMRecommendVO *)LMRecommendVOWithJSONString:(NSString *)jsonString usingEncoding:(NSStringEncoding)stringEncoding error:(NSError **)error;
+ (LMRecommendVO *)LMRecommendVOWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)LMRecommendVOListWithArray:(NSArray *)array;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString * articleUuid;
@property (nonatomic, copy) NSString * userUuid;
@property (nonatomic, copy) NSString * articleTitle;
@property (nonatomic, copy) NSString * articleContent;
@property (nonatomic, copy) NSString * publishTime;
@property (nonatomic, copy) NSString * articleName;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * headImgUrl;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * franchisee;
@property (nonatomic, copy) NSString * sign;
@property (nonatomic, copy) NSString * group;
@property (nonatomic, copy) NSString * category;



@end
