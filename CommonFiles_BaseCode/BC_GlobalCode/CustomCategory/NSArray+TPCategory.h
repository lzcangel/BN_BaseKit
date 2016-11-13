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

typedef void (^BN_dataRefreshRBlock)();

@interface BN_ArrayLoadSupport : NSObject

@property(nonatomic,assign)NetLoadEvent loadEvent;

- (void)setDataRefreshblock:(BN_dataRefreshRBlock)block;

@end

@interface NSArray (TPCategory)

@property(nonatomic,strong)NSNumber *networkTotal;

@property(nonatomic,strong)BN_ArrayLoadSupport *loadSupport;

- (instancetype)initFromNet;

@end

