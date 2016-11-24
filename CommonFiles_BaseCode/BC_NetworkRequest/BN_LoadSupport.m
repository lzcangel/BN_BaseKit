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
@property (nonatomic, copy)BN_dataRefreshFailBlock refreshDataFailBlock;

@end

@implementation BN_LoadSupport

- (void)setLoadEvent:(NetLoadEvent)loadEvent
{
    _loadEvent = loadEvent;
    if (loadEvent == NetLoadSuccessfulEvent && self.refreshDatablock != nil) {
        self.refreshDatablock();
    }
}

- (void)setLoadFailEvent:(NetLoadEvent)loadFailEvent
{
    if (loadFailEvent == NetLoadFailedEvent) {
        self.netRemark = @"网络请求失败";
    }
    if (self.refreshDataFailBlock) {
        self.refreshDataFailBlock(loadFailEvent,self.netRemark);
    }
}

- (void)setDataRefreshblock:(BN_dataRefreshBlock)block
{
    self.refreshDatablock = block;
}

- (void)setDataRefreshFailBlock:(BN_dataRefreshFailBlock)block
{
    self.refreshDataFailBlock = block;
}
@end
