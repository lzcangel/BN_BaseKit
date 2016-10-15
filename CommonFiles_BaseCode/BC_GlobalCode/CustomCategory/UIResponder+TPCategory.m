//
//  UIResponder+TPCategory.m
//  ShiJuRen
//
//  Created by xuwk on 15/8/28.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "UIResponder+TPCategory.h"

@implementation UIResponder (TPCategory)

- (UIViewController *)getViewController
{
    id next = [self nextResponder];
    while ((![next isKindOfClass:[UIViewController class]]) && next != nil)
    {
        next = [next nextResponder];
    }
    return next;
}

@end
