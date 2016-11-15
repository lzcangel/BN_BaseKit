//
//  NSArray+TPCategory.h
//  ShiJuRen
//
//  Created by xuwk on 15/9/10.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "BC_ToolRequest.h"
#import "BN_LoadSupport.h"
#import "BN_DataModel.h"

@interface NSArray (TPCategory)<BN_DataModel>

@property(nonatomic,strong)NSNumber *networkTotal;

- (instancetype)initFromNet;

- (NSArray *)map:(id (^) (id element))block;

- (NSArray *)filter:(BOOL (^) (id element))block;

@end

