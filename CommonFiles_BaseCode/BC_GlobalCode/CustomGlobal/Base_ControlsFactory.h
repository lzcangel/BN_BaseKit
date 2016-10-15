//
//  QJTL_ControlsFactory.h
//  QJTLBaseFramework
//
//  Created by qijuntonglian on 15/3/12.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Base_ControlsFactory : NSObject

+ (UIButton *)createButtonWithTitle:(NSString *)titleT normalImage:(NSString *)normalImage heightedImage:(NSString *)heightedImage;

+ (UIButton *)createButtonWithFrame:(CGRect)rect Image:(NSString *)image HeightLightImage:(NSString *)heightLightImage LeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight;

+ (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text;

+ (UITextField *)createTextFieldWithPlaceholder:(NSString *)text fontSize:(CGFloat)size tag:(NSInteger)kViewTag;

+ (UITextField *)getTextFieldWithFrame:(CGRect)rect withTitle:(NSString *)title withPlaceholder:(NSString *) placeholederText rightTitle:(NSString *)rightTitle;

+ (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text font:(int)font;

@end
