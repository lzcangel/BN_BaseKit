//
//  BN_LoadSupport.m
//  BN_BaseKit
//
//  Created by newman on 16/11/14.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BN_LoadSupport.h"

@interface BN_LoadSupport()

@property (nonatomic, copy)BN_dataRefreshBlock refreshDatablock;

@end

@implementation BN_LoadSupport

- (void)setLoadEvent:(NetLoadEvent)loadEvent
{
    _loadEvent = loadEvent;
    if (loadEvent == NetLoadSuccessfulEvent && self.refreshDatablock != nil) {
        self.refreshDatablock();
    }
}

- (void)setDataRefreshblock:(BN_dataRefreshBlock)block
{
    self.refreshDatablock = block;
}

@end
