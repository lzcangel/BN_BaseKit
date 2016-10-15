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

#define TEXT(name) [NSString imageNamed:name]

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

// 系统背景颜色设定
#define ColorBackground    [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
#define ColorTableViewCell [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
#define ColorTitle         [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
#define ColorNav           [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
#define ColorTab           [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define Font1 [UIFont systemFontOfSize: 13.0]
#define Font2 [UIFont systemFontOfSize: 14.0]
#define Font3 [UIFont systemFontOfSize: 15.0]
#define Font4 [UIFont systemFontOfSize: 16.0]
#define Font5 [UIFont systemFontOfSize: 17.0]
#define Font6 [UIFont systemFontOfSize: 18.0]

#endif
