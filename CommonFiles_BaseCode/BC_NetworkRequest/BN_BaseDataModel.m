//
//  BN_BaseDataModel.m
//  BN_BaseKit
//
//  Created by newman on 16/11/14.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BN_BaseDataModel.h"

@implementation BN_BaseDataModel

@synthesize loadSupport = _loadSupport;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loadSupport = [[BN_LoadSupport alloc]init];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if (value != nil)self.loadSupport.haveData = YES;
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    [super setValue:value forKeyPath:keyPath];
    if (value != nil)self.loadSupport.haveData = YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
    if (value != nil)self.loadSupport.haveData = YES;
}

@end
