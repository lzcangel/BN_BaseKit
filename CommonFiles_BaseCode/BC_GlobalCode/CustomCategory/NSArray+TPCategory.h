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

@interface BN_ArrayLoadSupport : NSObject

@property(nonatomic,assign)NetLoadEvent loadEvent;

@end

@interface NSArray (TPCategory)

@property(nonatomic,strong)NSNumber *networkTotal;

@property(nonatomic,strong)BN_ArrayLoadSupport *loadSupport;

- (instancetype)initFromNet;

@end

