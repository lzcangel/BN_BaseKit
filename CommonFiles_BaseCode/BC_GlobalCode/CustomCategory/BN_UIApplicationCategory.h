//
//  BN_UIApplicationCategory.h
//  BN_BaseKit
//
//  Created by pooh on 2017/1/12.
//  Copyright © 2017年 pooh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIApplication (BNYCategory)

- (void)bn_sendAction:(SEL)action to:(id)responder from:(UIControl*)control forEvent:(UIEvent*)event;


@end
