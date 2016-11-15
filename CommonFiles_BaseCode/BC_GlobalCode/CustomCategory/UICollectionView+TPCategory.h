//
//  UICollectionView+TPCategory.h
//  BN_BaseKit
//
//  Created by newman on 16/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BC_ToolRequest.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void (^BN_UICRefreshingBlock)();

@interface UICollectionView (TPCategory)

@property (nonatomic, copy)BN_UICRefreshingBlock headerRefreshDatablock;
@property (nonatomic, copy)BN_UICRefreshingBlock footerRefreshDatablock;

@property (nonatomic, strong)NSMutableArray *bn_tableViewDataArray;
@property (nonatomic, strong)RACDisposable *bn_dataDisposable;

- (void)setHeaderRefreshDatablock:(BN_UICRefreshingBlock)headerRefreshDatablock footerRefreshDatablock:(BN_UICRefreshingBlock)footerRefreshDatablock;

- (void)setCollectionViewData:(NSMutableArray *)dataArray;

@end
