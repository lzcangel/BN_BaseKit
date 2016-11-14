//
//  ViewController.m
//  BN_BaseKit
//
//  Created by newman on 16/10/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>
#import "demoViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIView+LoadCategory.h"
#import "UITableView+TPCategory.h"

@interface ViewController ()

@property (nonatomic, strong)demoViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.viewModel = [[demoViewModel alloc]init];
    
    //设置上拉加载和下拉刷新方法
    __weak typeof(self) temp = self;
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.viewModel getAdvertisementListArrayClearData:YES];
    } footerRefreshDatablock:^{
        [temp.viewModel getAdvertisementListArrayClearData:NO];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.advertisementArray];
    
    //刷新数据
    [self.viewModel getAdvertisementListArrayClearData:YES];
    
    [self.viewModel.advertisementArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.advertisementArray];
    
    
//    Advertisement *ddd = [[Advertisement alloc]init];
//    
//    NSLog(@"ASSRRRR %@",ddd);
//    Advertisement *sss = [ddd mj_setKeyValues:@{@"picUrl":@"eweww"}];
//    
//    NSLog(@"ASSRRRR %@",ddd);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.advertisementArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    声明静态字符串型对象，用来标记重用单元格
    Advertisement *data = self.viewModel.advertisementArray[indexPath.row];
    
    static NSString *TableSampleIdentifier = @"SJR_MessageTableViewCell";
    //    用TableSampleIdentifier表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    cell.textLabel.text = data.picUrl;
    return cell;
}


@end
