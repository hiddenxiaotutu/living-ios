
//
//  FitConsts.h
//  FitTrainer
//
//  Created by Huasheng on 15/8/20.
//  Copyright (c) 2015年 Huasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

//------------------个推配置--------------------

#define gtAppID                 @"OlmML6qokB8XngS0TXWAn1"
#define gtAppKey                @"4ftC7KlJzZ64iK7LL6G51"
#define gtAppSecret             @"cqVpdfUZVo8NkJnc4gTCI4"
#define gtMasterSecret          @"m9U6Js9OVM7cQSehxZpvC3"

//------------------高德配置--------------------

#define amapKey                 @"883b5da0b7fdb9f70dde28fd930a8037"

//------------------第三方分享-------------------

#define umAppKey                @"55d57f0d67e58ed077003880"

#define umShareAppKey           @"560274c367e58ec5cb004a8d"

#define wxAppID                 @"wx027975c909c0604e"
#define wxAppSecret             @"1ae2cd63192bd304e10869eeeed1ce8f"

//------------------界面常量--------------------

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kNaviHeight              44.0f
#define kToolBarHeight           49.0f
#define kStatuBarHeight          20.0f

#define SETTINGS_SECTION_HEIGHT     15
#define SETTINGS_CELL_HEIGHT        45


//------------------日期格式字符串--------------------

#define DATE_TIME_FORMAT        @"yyyy-MM-dd HH:mm:ss"

//----------------字号分级------------------

#define TEXT_FONT_LEVEL_1           [UIFont systemFontOfSize:16]
#define TEXT_FONT_LEVEL_2           [UIFont systemFontOfSize:14]
#define TEXT_FONT_LEVEL_3           [UIFont systemFontOfSize:12]
#define TEXT_FONT_LEVEL_4           [UIFont systemFontOfSize:10]
#define TEXT_FONT_LEVEL_5           [UIFont systemFontOfSize: 8]

//                特殊字形
#define TEXT_FONT_BOLDOBLIQUE_12    [UIFont fontWithName:@"Helvetica-BoldOblique" size:12]
#define TEXT_FONT_BOLDOBLIQUE_14    [UIFont fontWithName:@"Helvetica-BoldOblique" size:14]
#define TEXT_FONT_BOLDOBLIQUE_16    [UIFont fontWithName:@"Helvetica-BoldOblique" size:16]
#define TEXT_FONT_BOLDOBLIQUE_28    [UIFont fontWithName:@"Helvetica-BoldOblique" size:28]
#define TEXT_FONT_BOLDOBLIQUE_50    [UIFont fontWithName:@"Helvetica-BoldOblique" size:50]
#define TEXT_FONT_BOLD_12           [UIFont fontWithName:@"Helvetica-Bold"        size:12]
#define TEXT_FONT_BOLD_14           [UIFont fontWithName:@"Helvetica-Bold"        size:14]
#define TEXT_FONT_BOLD_16           [UIFont fontWithName:@"Helvetica-Bold"        size:16]
#define TEXT_FONT_BOLD_18           [UIFont fontWithName:@"Helvetica-Bold"        size:18]
#define TEXT_FONT_OBLIQUE_12        [UIFont fontWithName:@"Helvetica-Oblique"     size:12]

//------------------色值--------------------

#define TEXT_COLOR_LEVEL_1          [UIColor blackColor]
#define TEXT_COLOR_LEVEL_2          [UIColor darkGrayColor]
#define TEXT_COLOR_LEVEL_3          [UIColor grayColor]
#define TEXT_COLOR_LEVEL_4          [UIColor lightGrayColor]
#define TEXT_COLOR_LEVEL_5          [UIColor colorWithRed:0.8   green:0.8   blue:0.8   alpha:1]

#define PLACEHOLDER_COLOR           [UIColor colorWithRed:174.0/255 green:174.0/255 blue:174.0/255  alpha:1]

#define LINE_COLOR                  [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255  alpha:1]
#define LINE_COLOR_MASK             [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255  alpha:0.5]
#define BG_GRAY_COLOR               [UIColor colorWithRed:240.0/255 green:241.0/255 blue:242.0/255  alpha:1]
#define TABBAR_COLOR                [UIColor colorWithRed:51.0/255  green:51.0/255 blue:51.0/255    alpha:1]
#define BTN_ORANGE_COLOR            [UIColor colorWithRed:0.980     green:0.675     blue:0.286      alpha:1]

#define ORANGE_COLOR                [UIColor colorWithRed:1.000 green:0.596 blue:0.000 alpha:1]
#define BLUE_COLOR                  [UIColor colorWithRed:0.000 green:0.424 blue:0.980 alpha:1]
#define YELLOW_COLOR                [UIColor colorWithRed:1.000 green:0.753 blue:0.208 alpha:1]
#define MASK_COLOR                  [UIColor colorWithRed:0     green:0     blue:0     alpha:0.6]
#define MASK_DARK_COLOR             [UIColor colorWithRed:0     green:0     blue:0     alpha:0.8]
#define MASK_ALL_COLOR              [UIColor colorWithRed:0     green:0     blue:0     alpha:1]

#define COLOR_RED_LIGHT             [UIColor colorWithRed:0.900 green:0.110 blue:0.140 alpha:1]
#define COLOR_BLUE_LIGHT            [UIColor colorWithRed:0.150 green:0.780 blue:0.866 alpha:1]
#define COLOR_BLUE_DARK             [UIColor colorWithRed:0.000 green:0.630 blue:0.720 alpha:1]
#define COLOR_GREEN_LIGHT           [UIColor colorWithRed:0.546 green:0.766 blue:0.293 alpha:1]
#define COLOR_GREEN_DARK            [UIColor colorWithRed:0.430 green:0.625 blue:0.210 alpha:1]
#define COLOR_GRAY_LIGHT            [UIColor colorWithRed:0.400 green:0.400 blue:0.400 alpha:1]
#define COLOR_GRAY_DARK             [UIColor colorWithRed:0.303 green:0.303 blue:0.303 alpha:1]
#define COLOR_BLACK_LIGHT           [UIColor colorWithRed:0.200 green:0.200 blue:0.200 alpha:1]
#define COLOR_RANK_TOP              [UIColor colorWithRed:246 / 255.0 green:171 / 255.0 blue:38 / 255.0 alpha:1]
#define COLOR_RANK_BACKGROUND       [UIColor colorWithRed:80 / 255.0 green:80 / 255.0 blue:85 / 255.0 alpha:1]
#define COLOR_REDPACKET_BG          [UIColor colorWithRed:251 / 255.0 green:188 / 255.0 blue:55 / 255.0 alpha:1]
#define COLOR_HOME_YELLOW           [UIColor colorWithRed:246 / 255.0 green:172 / 255.0 blue:34 / 255.0 alpha:1]
#define COLOR_TEXT_BLUE             [UIColor colorWithRed:0 / 255.0 green:182 / 255.0 blue:242 / 255.0 alpha:1]
#define COLOR_BGVIEW_GREEN          [UIColor colorWithRed:72 / 255.0 green:206 / 255.0 blue:164 / 255.0 alpha:1]
#define COLOR_CASELBL_BORDER        [UIColor colorWithRed:174 / 255.0 green:174 / 255.0 blue:174 / 255.0 alpha:1]

#define LIVING_COLOR                [UIColor colorWithRed:0/255.0 green:130/255.0 blue:230.0/255.0 alpha:1.0]



//------------------Web页面地址--------------------

// * 使用协议 *
extern NSString *const SERVICE_AGREEMENTS_URL;


//------------------健身--------------------

#define FOOD_TYPE_CARBOHYDRATE      @"carbohydrate"
#define FOOD_TYPE_FRUIT             @"fruit"
#define FOOD_TYPE_PROTEIN           @"protein"
#define FOOD_TYPE_FAT               @"fat"
#define FOOD_TYPE_OTHER             @"other"

#define MEAL_TYPE_BREAKFAST         @"breakfast"
#define MEAL_TYPE_LUNCH             @"lunch"
#define MEAL_TYPE_DINNER            @"dinner"
#define MEAL_TYPE_SNACK             @"snack"

#define GOODS_CATEGORY_TYPE_Peican          @"PeiCan"
#define GOODS_CATEGORY_TYPE_Zhoubian        @"ZhouBian"
#define GOODS_CATEGORY_TYPE_Bupin           @"BuPin"
#define GOODS_CATEGORY_TYPE_Zhinengcheng    @"ZhiNengCheng"


//---------------------重新登录提示语----------------------
#define reLoginTip @"账号已在其他设备上登录，请重新登录！"
#define imageH   (kScreenWidth-160)*2/3

#define imageW  kScreenWidth/2

