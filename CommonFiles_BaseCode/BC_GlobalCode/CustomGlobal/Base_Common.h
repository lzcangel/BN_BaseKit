//
//  QJTL_Common.h
//  QJTLBaseFramework
//
//  Created by qijuntonglian on 15/3/12.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import"ARCMacros.h"

#ifndef QJTLBaseFramework_QJTL_Common_h

#define QJTLBaseFramework_QJTL_Common_h

#define IOSVersion [[UIDevice currentDevice].systemVersion floatValue]

#define IMAGE(name) [UIImage imageNamed:name]

#define IMAGEOriginal(name) [IMAGE(name) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define TEXT(name) NSLocalizedString(name, nil)

///DocumentPath路径设置
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
///CachePath路径设置
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
///TempPath路径设置
#define TempPath NSTemporaryDirectory()

///获取delegate
#define APP_DELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

///当前屏幕rect
#define DeviceRect [UIScreen mainScreen].bounds
///当前屏幕宽度
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
///当前屏幕高度
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
//当前导航栏高度
#define NavHeight self.navigationController.navigationBar.frame.size.height
//当前Tab高度
#define TabHeight self.tabBarController.tabBar.frame.size.height
//选择器通用高度
#define TopSegmmentControlHeight 36

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


#define RECT_CHANGE_x(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(X(v), Y(v), w, h)

//log打印
#define NSLog(s,...) NSLog( @"<%@:(%d)> :%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

//判断机型
#define IS_IPHONE_5_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

//颜色宏定义
#define RGB(r,g,b)        [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f]
#define RGBA(r,g,b,a)     [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
#define RGBAHEX(hex,a)    RGBA((float)((hex & 0xFF0000) >> 16),(float)((hex & 0xFF00) >> 8),(float)(hex & 0xFF),a)

// 系统颜色设定
#define ColorBtnYellow     RGBAHEX(0xcaa161,1.0f)
#define ColorBlack         RGBAHEX(0x000000,1.0f)
#define ColorGray          RGBAHEX(0x333333,1.0f)
#define ColorLightGray     RGBAHEX(0x626262,1.0f)
#define ColorLine          RGBAHEX(0xeeeeee,1.0f)
#define ColorWhite         RGBAHEX(0xffffff,1.0f)
#define ColorBackground    RGBAHEX(0xf5f5f5,1.0f)
#define ColorRed           RGBAHEX(0xe5262a,1.0f)

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


//系统字体设定
#define Font8 [UIFont systemFontOfSize: 8.0]
#define Font10 [UIFont systemFontOfSize: 10.0]
#define Font12 [UIFont systemFontOfSize: 12.0]
#define Font13 [UIFont systemFontOfSize: 13.0]
#define Font14 [UIFont systemFontOfSize: 14.0]
#define Font15 [UIFont systemFontOfSize: 15.0]
#define Font16 [UIFont systemFontOfSize: 16.0]

#endif
