//
//  UITableView+TPCategory.m
//  BN_BaseKit
//
//  Created by newman on 16/11/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "UITableView+TPCategory.h"
#import "NSArray+TPCategory.h"
#import <MJRefresh.h>


static const void *headerUtilityKey = &headerUtilityKey;

static const void *footerUtilityKey = &footerUtilityKey;

@implementation UITableView (TPCategory)

@dynamic footerRefreshDatablock;
- (BN_UIRefreshingBlock)footerRefreshDatablock {
    return objc_getAssociatedObject(self, footerUtilityKey);
}

- (void)setFooterRefreshDatablock:(BN_UIRefreshingBlock)footerRefreshDatablock {
    objc_setAssociatedObject(self, footerUtilityKey, footerRefreshDatablock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@dynamic headerRefreshDatablock;
- (BN_UIRefreshingBlock)headerRefreshDatablock {
    return objc_getAssociatedObject(self, headerUtilityKey);
}

- (void)setHeaderRefreshDatablock:(BN_UIRefreshingBlock)headerRefreshDatablock {
    objc_setAssociatedObject(self, headerUtilityKey, headerRefreshDatablock, OBJC_ASSOCIATION_COPY_NONATOMIC);
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

- (void)setHeaderRefreshDatablock:(BN_UIRefreshingBlock)headerRefreshDatablock footerRefreshDatablock:(BN_UIRefreshingBlock)footerRefreshDatablock
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

- (void)setTableViewData:(NSMutableArray *)dataArray
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
                self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

