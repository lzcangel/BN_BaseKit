//
//  UIView+LoadCategory.m
//  ShiJuRen
//
//  Created by xuwk on 15/9/25.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "UIView+LoadCategory.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <objc/runtime.h>
#import "BN_NoDataView.h"
#import "BC_ToolRequest.h"
#import"Base_Common.h"

static const void *UtilityKey = &UtilityKey;

@implementation UIView (LoadCategory)

- (UIButton *)netLoadView {
    return objc_getAssociatedObject(self, @selector(netLoadView));
}

- (void)setNetLoadView:(UIButton *)value {
    objc_setAssociatedObject(self, @selector(netLoadView), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)noDataView {
    return objc_getAssociatedObject(self, @selector(noDataView));
}

- (void)setNoDataView:(UIView *)value {
    objc_setAssociatedObject(self, @selector(noDataView), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (NSNumber *)netTag {
    return objc_getAssociatedObject(self, @selector(netTag));
}

- (void)setNetTag:(NSNumber *)value {
    objc_setAssociatedObject(self, @selector(netTag), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//添加网络刷新block
@dynamic refreshDatablock;
- (UINetBlock)refreshDatablock {
    return objc_getAssociatedObject(self, UtilityKey);
}

- (void)setRefreshDatablock:(UINetBlock)refreshDatablock {
    objc_setAssociatedObject(self, UtilityKey, refreshDatablock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)setRefreshBlock:(UINetBlock)block
{
    self.refreshDatablock = [block copy];
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BN_RefreshAllView object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        if(self.refreshDatablock != nil)
        {
            self.refreshDatablock();
        }
    }
     ];
}


- (void)loadingState:(int)state data:(id)data
{
    self.netTag = [NSNumber numberWithInt:state];
    if([self isKindOfClass:[UITableView class]])
    {
        ((UIScrollView *)self).scrollEnabled = YES;
    }
    if(self.netLoadView == nil)
    {
        self.netLoadView = [[UIButton alloc]initWithFrame:self.bounds];
        [self.netLoadView addTarget:self action:@selector(goToRZ) forControlEvents:UIControlEventTouchUpInside];
    }
    self.netLoadView.backgroundColor = [UIColor whiteColor];
    [self.netLoadView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.netLoadView.titleLabel.font = [UIFont systemFontOfSize:12];
    self.netLoadView.frame  = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.noDataView removeFromSuperview];
    self.noDataView = nil;
    
    switch (state) {
        case NetLoadSuccessfulEvent://成功
        {
            [self.netLoadView removeFromSuperview];
            if(data == nil || ([data isKindOfClass:[NSArray class]] && ((NSArray *)data).count == 0))
            {
                self.noDataView = [[[NSBundle mainBundle] loadNibNamed:@"BN_NoDataView" owner:nil options:nil] firstObject];
                self.noDataView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
                if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
                [self addSubview:self.noDataView];
                
                [self.netLoadView setImage:nil forState:UIControlStateNormal];
                [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
                self.netLoadView.backgroundColor = [UIColor clearColor];
                [self addSubview:self.netLoadView];
                NSLog(@"数据为空");
            }
        }
            break;
        case NetFailureEvent://失败
        {
            if(data == nil)
            {
                [self.netLoadView setImage:IMAGE(@"SJR_NetFailureEvent") forState:UIControlStateNormal];
                [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
                if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
                [self addSubview:self.netLoadView];
                NSLog(@"没数据又失败");
            }
            else
            {
                [self.netLoadView removeFromSuperview];
                NSLog(@"在有数据的情况下网络失败");
            }
        }
            break;
        case NetTokenExpiredEvent://用户token无效
        {
            [self.netLoadView setImage:IMAGE(@"SJR_NetTokenExpiredEvent") forState:UIControlStateNormal];
            [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
            if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
            [self addSubview:self.netLoadView];
            NSLog(@"用户token无效");
        }
            break;
        case NetNotCertifiedEvent://您还未认证，请先认证
        {
            [self.netLoadView setImage:IMAGE(@"SJR_NetNotCertifiedEvent") forState:UIControlStateNormal];
            [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
            if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
            [self addSubview:self.netLoadView];
            NSLog(@"还未认证");
        }
            break;
        case NetUnderReviewEvent://您的认证正在审核中，请稍等
        {
            [self.netLoadView setImage:IMAGE(@"SJR_NetUnderReviewEvent") forState:UIControlStateNormal];
            [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
            if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
            [self addSubview:self.netLoadView];
            NSLog(@"正在审核中");
        }
            break;
        case NetCertifiedFailedEvent://您的资料认证失败，请重新认证
        {
            [self.netLoadView setImage:IMAGE(@"SJR_NetCertifiedFailedEvent") forState:UIControlStateNormal];
            [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
            if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
            [self addSubview:self.netLoadView];
            NSLog(@"认证失败");
        }
            break;
        case NetLoadingEvent://正在加载中
        {
            if(data == nil  || ([data isKindOfClass:[NSArray class]] && ((NSArray *)data).count == 0))
            {
                [self.netLoadView setImage:nil forState:UIControlStateNormal];
                [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
                [self addSubview:self.netLoadView];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.netLoadView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
                });
            }
            else
            {
                [self.netLoadView removeFromSuperview];
            }
            if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
        }
            break;
        case NetLoadFailedEvent://网络请求失败
        {
            if(data == nil)
            {
                self.netLoadView.backgroundColor = [UIColor whiteColor];
                [self.netLoadView setImage:IMAGE(@"SJR_NetLoadFailedEvent") forState:UIControlStateNormal];
                [self.netLoadView setTitle:@"" forState:UIControlStateNormal];
                if([self isKindOfClass:[UITableView class]])((UIScrollView *)self).scrollEnabled = NO;
                [self addSubview:self.netLoadView];
                NSLog(@"没数据又失败");
            }
            else
            {
                [self.netLoadView removeFromSuperview];
                NSLog(@"在有数据的情况下网络失败");
            }
            
        }
            break;
            
        default:
        {
            [self addSubview:self.netLoadView];
            NSLog(@"网络无条件失败");
        }
            break;
    }
    //    if(self.netLoadView == nil)
    //    {
    //        self.netLoadView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    //        self.netLoadView.backgroundColor = [UIColor blueColor];
    //    }
    //    [self addSubview:self.netLoadView];
}

- (void)goToRZ
{
    NSLog(@"点击事件 状态为%@",self.netTag);
    
    switch (self.netTag.intValue) {
        case NetLoadSuccessfulEvent://成功
        {
            if(self.refreshDatablock != nil)
            {
                self.refreshDatablock();
            }
        }
            break;
        case NetFailureEvent://失败
        {
            if(self.refreshDatablock != nil)
            {
                self.refreshDatablock();
            }
        }
            break;
        case NetTokenExpiredEvent://用户token无效
        {
//            [SJR_UserInfo sharedUserInfo].isLoginView = YES;
//            SJR_LoginViewController *loginViewController = [[SJR_LoginViewController alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }
            break;
        case NetNotCertifiedEvent://您还未认证，请先认证
        {
//            SJR_SuccessfulViewController *successfulViewController = [[SJR_SuccessfulViewController alloc]init];
//            successfulViewController.title = @"请先完成认证";
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:successfulViewController];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
//                ;
//            }];
            break;
        }
        case NetUnderReviewEvent://您的认证正在审核中，请稍等
        {
            if(self.refreshDatablock != nil)
            {
                self.refreshDatablock();
            }
        }
            break;
        case NetCertifiedFailedEvent://您的资料认证失败，请重新认证
        {
//            SJR_SuccessfulViewController *successfulViewController = [[SJR_SuccessfulViewController alloc]init];
//            successfulViewController.title = @"请先完成认证";
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:successfulViewController];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
//                ;
//            }];
        }
            break;
        case NetLoadingEvent://正在加载中
        {
            ;
        }
            break;
        case NetLoadFailedEvent://网络请求失败
        {
            if(self.refreshDatablock != nil)
            {
                self.refreshDatablock();
            }
        }
            break;
            
        default:
        {
            if(self.refreshDatablock != nil)
            {
                self.refreshDatablock();
            }
        }
            break;
    }
}


@end


