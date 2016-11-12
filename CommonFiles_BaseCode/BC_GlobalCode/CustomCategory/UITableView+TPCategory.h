//
//  UITableView+TPCategory.h
//  BN_BaseKit
//
//  Created by newman on 16/11/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BC_ToolRequest.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void (^BN_UIRefreshingBlock)();




@interface UITableView (TPCategory)

@property (nonatomic, copy)BN_UIRefreshingBlock headerRefreshDatablock;
@property (nonatomic, copy)BN_UIRefreshingBlock footerRefreshDatablock;

@property (nonatomic, strong)NSMutableArray *bn_tableViewDataArray;
@property (nonatomic, strong)RACDisposable *bn_dataDisposable;

- (void)setHeaderRefreshDatablock:(BN_UIRefreshingBlock)headerRefreshDatablock footerRefreshDatablock:(BN_UIRefreshingBlock)footerRefreshDatablock;

- (void)setTableViewData:(NSMutableArray *)dataArray;

//- (void)setTableViewLoadEvent:(NetLoadEvent)loadEvent;

@end


