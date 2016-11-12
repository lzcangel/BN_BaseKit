//
//  NSArray+TPCategory.m
//  ShiJuRen
//
//  Created by xuwk on 15/9/10.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "NSArray+TPCategory.h"

@implementation BN_ArrayLoadSupport

@end

@implementation NSArray (TPCategory)

- (instancetype)initFromNet
{
    self = [self init];
    if (self) {
        self.loadSupport = [[BN_ArrayLoadSupport alloc]init];
    }
    return self;
}

- (NSNumber *)networkTotal {
    return objc_getAssociatedObject(self, @selector(networkTotal));
}

- (void)setNetworkTotal:(NSNumber *)value {
    objc_setAssociatedObject(self, @selector(networkTotal), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BN_ArrayLoadSupport *)loadSupport {
    return objc_getAssociatedObject(self, @selector(loadSupport));
}

- (void)setLoadSupport:(BN_ArrayLoadSupport *)value {
    objc_setAssociatedObject(self, @selector(loadSupport), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
