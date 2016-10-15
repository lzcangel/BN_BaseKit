//
//  QJTL_ UITabBarBaseController.h
//  CheGuLu
//
//  Created by qijuntonglian on 15/4/24.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Base_UITabBarBaseController : UITabBarController
@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;
@end
