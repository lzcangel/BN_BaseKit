//
//  BN_UIApplicationCategory.m
//  BN_BaseKit
//
//  Created by pooh on 2017/1/12.
//  Copyright © 2017年 pooh. All rights reserved.
//

#import "BN_UIApplicationCategory.h"
#import <objc/runtime.h>

@implementation UIApplication (BNYCategory)

+(void)load
{
    [self replaceMethodOfClass:[UIApplication class] originalSelector:@selector(sendAction:to:from:forEvent:) swizzledSelector:@selector(bn_sendAction:to:from:forEvent:)];
}

- (void)bn_sendAction:(SEL)action to:(id)responder from:(UIControl*)control forEvent:(UIEvent*)event {
//    if (YES)return;
    [self bn_sendAction:action to:responder from:control forEvent:event];
}

+ (void)replaceMethodOfClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    [self replaceMethodOfOriginalClass:class originalSelector:originalSelector swizzledClass:class swizzledSelector:swizzledSelector];
}

+ (void)replaceMethodOfOriginalClass:(Class)originalClass originalSelector:(SEL)originalSelector swizzledClass:(Class)swizzledClass swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(originalClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(originalClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
