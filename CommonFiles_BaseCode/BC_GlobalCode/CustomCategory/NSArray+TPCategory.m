//
//  NSArray+TPCategory.m
//  ShiJuRen
//
//  Created by xuwk on 15/9/10.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "NSArray+TPCategory.h"


@implementation NSArray (TPCategory)

- (instancetype)initFromNet
{
    self = [self init];
    if (self) {
        self.loadSupport = [[BN_LoadSupport alloc]init];
        self.loadSupport.haveData = YES;
    }
    return self;
}

- (NSNumber *)networkTotal {
    return objc_getAssociatedObject(self, @selector(networkTotal));
}

- (void)setNetworkTotal:(NSNumber *)value {
    objc_setAssociatedObject(self, @selector(networkTotal), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BN_LoadSupport *)loadSupport {
    return objc_getAssociatedObject(self, @selector(loadSupport));
}

- (void)setLoadSupport:(BN_LoadSupport *)value {
    objc_setAssociatedObject(self, @selector(loadSupport), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)map:(id (^) (id element))block
{
    if (!block) {
        NSAssert(NO, @"block is nil");
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id element in self) {
        id result = block(element);
        [array addObject:result ? result : [NSNull null]];
    }
    
    return array;
}

- (NSArray *)filter:(BOOL (^) (id element))block
{
    if (!block) {
        NSAssert(NO, @"block is nil");
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id element in self) {
        if (block(element)) {
            [array addObject:element];
        }
    }
    
    return array;
}

@end
