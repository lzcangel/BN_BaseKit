//  github: https://github.com/MakeZL/UIView-Category
//  author: @email <120886865@qq.com>
//
//  UIView+MBIBnspectable.m
//  MakeZL
//
//  Created by 张磊 on 15/4/29.
//  Copyright (c) 2015年 www.weibo.com/makezl All rights reserved.
//

#import "UIView+MBIBnspectable.h"

@implementation UIView (MBIBnspectable)

#pragma mark - setCornerRadius/borderWidth/borderColor
- (void)setQ_CornerRadius:(NSInteger)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (NSInteger)q_CornerRadius{
    return self.layer.cornerRadius;
}

- (void)setQ_BorderWidth:(NSInteger)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (NSInteger)q_BorderWidth{
    return self.layer.borderWidth;
}

- (void)setQ_BorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)q_BorderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setQ_BorderHexRgb:(NSString *)borderHexRgb{
    NSScanner *scanner = [NSScanner scannerWithString:borderHexRgb];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    self.layer.borderColor = [self q_ColorWithRGBHex:hexNum].CGColor;
}

-(NSString *)q_BorderHexRgb{
    return @"0xffffff";
}

- (void)setQ_MasksToBounds:(BOOL)bounds{
    self.layer.masksToBounds = bounds;
}

- (BOOL)q_MasksToBounds{
    return self.layer.masksToBounds;
}

#pragma mark - hexRgbColor
- (void)setQ_HexRgbColor:(NSString *)hexRgbColor{
    NSScanner *scanner = [NSScanner scannerWithString:hexRgbColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    self.backgroundColor = [self q_ColorWithRGBHex:hexNum];
}

- (UIColor *)q_ColorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


- (NSString *)q_HexRgbColor{
    return @"0xffffff";
}

#pragma mark - setOnePx
- (void)setQ_OnePx:(BOOL)onePx{
    if (onePx) {
        CGRect rect = self.frame;
        rect.size.height = 1.0 / [UIScreen mainScreen].scale;
        self.frame = rect;
    }
}

- (BOOL)q_OnePx{
    return self.q_OnePx;
}

- (void)setQ_ShadowColor:(UIColor *)q_ShadowColor
{
    self.layer.shadowColor = q_ShadowColor.CGColor;
}

- (UIColor *)q_ShadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setQ_ShadowOffset:(CGSize)q_ShadowOffset
{
    self.layer.shadowOffset = q_ShadowOffset;
}

- (CGSize)q_ShadowOffset
{
    return self.layer.shadowOffset;
}

- (void)setQ_ShadowOpacity:(CGFloat)q_ShadowOpacity
{
    self.layer.shadowOpacity = q_ShadowOpacity;
}

- (CGFloat)q_ShadowOpacity
{
    return self.layer.shadowOpacity;
}

- (void)setQ_ShadowRadius:(CGFloat)q_ShadowRadius
{
    self.layer.shadowRadius = q_ShadowRadius;
}

- (CGFloat)q_ShadowRadius
{
    return self.layer.shadowRadius;
}

@end
