//
//  UIView+LoadCategory.h
//  BN_BaseKit
//
//  Created by newman on 16/11/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BN_NoDataView.h"

typedef void (^UINetBlock)();

@interface UIView (LoadCategory)

@property (nonatomic,strong)UIButton *netLoadView;
@property (nonatomic,strong)BN_NoDataView *noDataView;
@property (nonatomic,strong)NSNumber *netTag;
@property (nonatomic, copy)UINetBlock refreshDatablock;

- (void)loadingState:(int)state data:(id)data;

- (void)setRefreshBlock:(UINetBlock)block;

@end
