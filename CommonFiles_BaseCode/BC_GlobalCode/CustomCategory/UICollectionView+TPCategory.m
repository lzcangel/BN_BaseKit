//
//  UICollectionView+TPCategory.m
//  BN_BaseKit
//
//  Created by newman on 16/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "UICollectionView+TPCategory.h"
#import "NSArray+TPCategory.h"
#import <MJRefresh.h>

static const void *headerCUtilityKey = &headerCUtilityKey;

static const void *footerCUtilityKey = &footerCUtilityKey;

@implementation UICollectionView (TPCategory)

@dynamic footerRefreshDatablock;
- (BN_UICRefreshingBlock)footerRefreshDatablock {
    return objc_getAssociatedObject(self, footerCUtilityKey);
}

- (void)setFooterRefreshDatablock:(BN_UICRefreshingBlock)footerRefreshDatablock {
    objc_setAssociatedObject(self, footerCUtilityKey, footerRefreshDatablock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@dynamic headerRefreshDatablock;
- (BN_UICRefreshingBlock)headerRefreshDatablock {
    return objc_getAssociatedObject(self, headerCUtilityKey);
}

- (void)setHeaderRefreshDatablock:(BN_UICRefreshingBlock)headerRefreshDatablock {
    objc_setAssociatedObject(self, headerCUtilityKey, headerRefreshDatablock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (RACDisposable *)bn_dataDisposable {
    return objc_getAssociatedObject(self, @selector(bn_dataDisposable));
}

- (void)setBn_dataDisposable:(RACDisposable *)value {
    objc_setAssociatedObject(self, @selector(bn_dataDisposable), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)bn_tableViewDataArray {
    return objc_getAssociatedObject(self, @selector(bn_tableViewDataArray));
}

- (void)setBn_tableViewDataArray:(NSMutableArray *)value {
    objc_setAssociatedObject(self, @selector(bn_tableViewDataArray), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeaderRefreshDatablock:(BN_UICRefreshingBlock)headerRefreshDatablock footerRefreshDatablock:(BN_UICRefreshingBlock)footerRefreshDatablock
{
    self.headerRefreshDatablock = headerRefreshDatablock;
    self.footerRefreshDatablock = footerRefreshDatablock;
    
    __weak typeof(self) temp = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        temp.headerRefreshDatablock();
    }];
    
    
    //    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    //        temp.footerRefreshDatablock();
    //    }];
}

- (void)setCollectionViewData:(NSMutableArray *)dataArray
{
    if (self.bn_dataDisposable != nil) {
        [self.bn_dataDisposable dispose];
        self.bn_dataDisposable = nil;
    }
    
    self.bn_tableViewDataArray = dataArray;
    
    @weakify(self);
    
    self.bn_dataDisposable = [RACObserve(self.bn_tableViewDataArray.loadSupport, loadEvent) subscribeNext:^(NSNumber *value) {
        @strongify(self);
        
        NetLoadEvent loadEvent = value.integerValue;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.bn_tableViewDataArray.networkTotal != nil && self.bn_tableViewDataArray.networkTotal.intValue <= self.bn_tableViewDataArray.count)
            {
                self.mj_footer = nil;
            }
            else
            {
                __weak typeof(self) temp = self;
                self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    temp.footerRefreshDatablock();
                }];
            }
        });
        
        if(loadEvent != NetLoadingEvent)
        {
            [self.mj_header endRefreshing];
            [self.mj_footer endRefreshing];
        }
        
        [self reloadData];
    }];
}

@end
