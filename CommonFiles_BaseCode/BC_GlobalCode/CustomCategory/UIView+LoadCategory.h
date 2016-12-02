//
//  UIView+LoadCategory.h
//  BN_BaseKit
//
//  Created by newman on 16/11/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BN_NoDataView.h"
#import "BN_DataModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void (^UINetBlock)();

@interface UIView (LoadCategory)

@property (nonatomic,strong)UIButton *netLoadView;
@property (nonatomic,strong)BN_NoDataView *noDataView;
@property (nonatomic,strong)NSNumber *netTag;
@property (nonatomic, copy)UINetBlock refreshDatablock;
@property (nonatomic, strong)RACDisposable *bn_disposable;
@property (nonatomic, strong)id<BN_DataModel> bn_data;

- (void)loadData:(id<BN_DataModel>)data;

- (void)setRefreshBlock:(UINetBlock)block;

+ (void)setLoginBlock:(UINetBlock)block;

@end
