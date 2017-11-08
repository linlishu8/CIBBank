//
//  ECMacro.h
//  EnCity
//
//  Created by 动感超人 on 2017/3/6.
//  Copyright © 2017年 liuwei. All rights reserved.
//

#ifndef ECMacro_h
#define ECMacro_h

///------------
/// AppDelegate
///------------

#define ECSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

///------
/// NSLog
///------

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#define MRCLogError(error) NSLog(@"Error: %@", error)

///------
/// Block
///------

typedef void (^VoidBlock)();


///----------------------
/// Persistence Directory
///----------------------

#define MRC_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

///-----
/// FMDB
///-----

#define MRC_FMDB_PATH [NSString stringWithFormat:@"%@/%@.db", MRC_DOCUMENT_DIRECTORY, MRC_APP_NAME]
#define MRCLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

///-----------
/// SSKeychain
///-----------

#define EC_SERVICE_NAME @"com.liuwei.EnCity"
#define EC_RAW_LOGIN    @"ECRawLogin"
#define EC_PASSWORD     @"ECPassword"
#define EC_ACCESS_TOKEN @"ECAccessToken"

///------
/// Color
///------

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define colorNavBackGround HexRGB(0x2a88de) //蓝色
#define colorButtonEnable HexRGB(0x82b2de) //淡一点的蓝色
#define colorViewBackGround HexRGB(0xdae1eb) //灰色
#define colorViewBorder HexRGB(0xcbd0db) //边框颜色（灰色）
#define colorFont HexRGB(0x808080) //灰色文字
#define colorViewTableView HexRGB(0xefeff4) //表格背景
#define colorViewTableHead HexRGB(0xf9f9f9) // 表头背景
#define colorIgnore HexRGB(0xe84c3d) //忽略按钮 红色

///------
/// ScreenSize
///------

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define SPLIT_LINE_WIDTH 1.0
#define SPLIT_LINE_HEIGHT SPLIT_LINE_WIDTH

///------
/// FontSize
///------

#define ECFont(x) [UIFont systemFontOfSize:HEIGHT_LFL(x)]
#define ECBoldFont(x) [UIFont boldSystemFontOfSize:HEIGHT_LFL(x)]

///---------
/// App Info
///---------

#define MRCApplicationVersionKey @"MRCApplicationVersionKey"
//https://itunes.apple.com/cn/app/apple-store/id1139059829?mt=8
#define MRC_APP_ID               @"961330940"
#define MRC_APP_STORE_URL        @"https://itunes.apple.com/cn/app/id"MRC_APP_ID"?mt=8"
#define MRC_APP_STORE_REVIEW_URL @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id="MRC_APP_ID@"&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"

#define MRC_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define MRC_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define MRC_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

//信息提示
#define Alert(msg) [[[UIAlertView alloc] initWithTitle:@"" message:(msg) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show]

#endif /* ECMacro_h */
