//
//  PPConfigs.h
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#pragma mark - device

#define IS_SCREEN568        (568.0f==[UIScreen mainScreen].bounds.size.height)
#define IS_IOS7             ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define LESS_THAN_IOS6      ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)

#pragma mark - UI elements

#define COLOR_MAIN_BG_GRAY  ([UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.0f])

#define COLOR_BTN_BG_GREEN  ([UIColor colorWithRed:0.14f green:0.71f blue:0.76f alpha:1.0f])
#define COLOR_BTN_BG_DARK_GRAY  ([UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.0f])

#define COLOR_TEXT_GREEN    ([UIColor colorWithRed:0.14f green:0.71f blue:0.76f alpha:1.0f])
#define COLOR_TEXT_GRAY     ([UIColor colorWithRed:0.58f green:0.58f blue:0.60f alpha:1.0f])

#define FONT_NORMAL         ([UIFont systemFontOfSize:15.0])

#pragma mark - map

#define BAIDU_MAP_KEY       @"NvozkPbOg6LxFaSOiADTsOkN"

#define MAKE_COOR_S(lat,lng)  (CLLocationCoordinate2DMake([lat floatValue]*0.00001, [lng floatValue]*0.00001))

#pragma mark - URLs

#define PP_SECRET_KEY       @"123#$%zz"

#define PP_BASE_DOMAIN      @"pig-parking.com"
#define PP_API_URL          @"http://www.sanxinba.cn/zz_manage/index.php?r=interface"

#pragma mark - DIRs

#define PATH_IN_DOCUMENTS_DIR(f) ([NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),f])
#define PATH_IN_CACHE_DIR(f) ([NSString stringWithFormat:@"%@/Documents/cache/%@", NSHomeDirectory(),f])