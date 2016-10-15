//
//  CALayer+TPCategory.m
//  ShiJuRenClient
//
//  Created by xuwk on 15/8/29.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "CALayer+TPCategory.h"

@implementation CALayer (TPCategory)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
