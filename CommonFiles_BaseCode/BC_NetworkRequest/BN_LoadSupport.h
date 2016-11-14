//
//  BN_LoadSupport.h
//  BN_BaseKit
//
//  Created by newman on 16/11/14.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BC_ToolRequest.h"

typedef void (^BN_dataRefreshBlock)();

@interface BN_LoadSupport : NSObject

@property(nonatomic,assign)NetLoadEvent loadEvent;
@property(nonatomic,assign)BOOL haveData;//只对model类型有效 对数组无效

- (void)setDataRefreshblock:(BN_dataRefreshBlock)block;

@end
