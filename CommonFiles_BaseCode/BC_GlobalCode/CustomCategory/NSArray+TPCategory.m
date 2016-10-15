//
//  NSArray+TPCategory.m
//  ShiJuRen
//
//  Created by xuwk on 15/9/10.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "NSArray+TPCategory.h"

@implementation NSArray (TPCategory)

- (NSNumber *)networkTotal {
    return objc_getAssociatedObject(self, @selector(networkTotal));
}

- (void)setNetworkTotal:(NSNumber *)value {
    objc_setAssociatedObject(self, @selector(networkTotal), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
