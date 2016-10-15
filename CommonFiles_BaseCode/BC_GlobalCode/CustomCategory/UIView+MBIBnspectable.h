//  github: https://github.com/MakeZL/UIView-Category
//  author: @email <120886865@qq.com>
//
//  UIView+MBIBnspectable.h
//  MakeZL
//
//  Created by 张磊 on 15/4/29.
//  Copyright (c) 2015年 www.weibo.com/makezl All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIView (MBIBnspectable)

@property (assign,nonatomic) IBInspectable NSInteger q_CornerRadius;
@property (assign,nonatomic) IBInspectable NSInteger q_BorderWidth;
@property (assign,nonatomic) IBInspectable BOOL      q_MasksToBounds;
// set border hex color
@property (strong,nonatomic) IBInspectable NSString  *q_BorderHexRgb;
@property (strong,nonatomic) IBInspectable UIColor   *q_BorderColor;
// set background hex color
@property (assign,nonatomic) IBInspectable NSString  *q_HexRgbColor;
@property (assign,nonatomic) IBInspectable BOOL      q_OnePx;

// set shadow color
@property (strong,nonatomic) IBInspectable UIColor *q_ShadowColor;
@property (assign,nonatomic) IBInspectable CGSize q_ShadowOffset;
@property (assign,nonatomic) IBInspectable CGFloat q_ShadowOpacity;
@property (assign,nonatomic) IBInspectable CGFloat q_ShadowRadius;

@end
