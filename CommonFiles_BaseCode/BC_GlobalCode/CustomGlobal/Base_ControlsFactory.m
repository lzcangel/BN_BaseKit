//
//  QJTL_ControlsFactory.m
//  QJTLBaseFramework
//
//  Created by qijuntonglian on 15/3/12.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "Base_ControlsFactory.h"
#import <UIKit/UIKit.h>
#import "Base_Common.h"

@implementation Base_ControlsFactory

+ (UIButton *)createButtonWithTitle:(NSString *)titleT normalImage:(NSString *)normalImage heightedImage:(NSString *)heightedImage
{
    UIButton *button          = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tmpNormalImage   = IMAGE(normalImage);
    UIImage *tmpHeightedImage = IMAGE(heightedImage);

    if (tmpNormalImage != nil)
    {
        [button setImage:IMAGE(normalImage)  forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:normalImage]  forState:UIControlStateNormal];
    }

    if (tmpHeightedImage != nil)
    {
        [button setImage:IMAGE(heightedImage)  forState:UIControlStateHighlighted];
    }else{
        [button setImage:[UIImage imageNamed:heightedImage]  forState:UIControlStateHighlighted];
    }

    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    if (titleT != nil)
    {
        [button setTitle:titleT forState:UIControlStateNormal];
    }

    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)rect Image:(NSString *)image HeightLightImage:(NSString *)heightLightImage LeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight
{
    //初始化sectionView
    UIButton *btn                = [[UIButton alloc]initWithFrame:rect];
    btn.titleLabel.font          = [UIFont systemFontOfSize: 13.0];

    CGSize imageSize             = IMAGE(image).size;
    UIImage *btnImage            = [IMAGE(image) stretchableImageWithLeftCapWidth:imageSize.width/2.0 topCapHeight:imageSize.height/2.0];
    [btn setImage:btnImage forState:UIControlStateNormal];

    imageSize                    = IMAGE(heightLightImage).size;
    UIImage *btnHeightLightImage = [IMAGE(heightLightImage) stretchableImageWithLeftCapWidth:imageSize.width/2.0 topCapHeight:imageSize.height/2.0];
    [btn setImage:btnHeightLightImage forState:UIControlStateHighlighted];
    
    return btn;
}

+ (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text
{
    UILabel *label                  = [[UILabel alloc]initWithFrame:rect];
    label.textColor                 = ColorTitle;
    label.textAlignment             = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor           = [UIColor clearColor];
    if (nil != text)
    {
        [label setText:text];
    }
    return label;
}


+ (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text font:(int)font
{
    UILabel *label        = [[UILabel alloc]initWithFrame:rect];
    label.font            = [UIFont systemFontOfSize:font];
    label.textColor       = [UIColor whiteColor];
    label.textAlignment   = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    if (nil != text)
    {
        [label setText:text];
    }
    return label;
}

+ (UITextField *)createTextFieldWithPlaceholder:(NSString *)text fontSize:(CGFloat)size tag:(NSInteger)kViewTag
{
    UITextField *textFieldRounded       = [[UITextField alloc] init];

    textFieldRounded.borderStyle        = UITextBorderStyleNone;
    textFieldRounded.textColor          = [UIColor blackColor];
    textFieldRounded.font               = [UIFont systemFontOfSize:size];
    textFieldRounded.placeholder        = text;
    textFieldRounded.backgroundColor    = [UIColor clearColor];
    textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;// no auto correction support
    textFieldRounded.keyboardType       = UIKeyboardTypeDefault;
    textFieldRounded.returnKeyType      = UIReturnKeyDone;
    textFieldRounded.clearButtonMode    = UITextFieldViewModeWhileEditing;// has a clear 'x' button to the right
    textFieldRounded.tag                = kViewTag;// tag this control so we can remove it later for recycled cells
    
    return textFieldRounded;
}
+ (UITextField *)getTextFieldWithFrame:(CGRect)rect withTitle:(NSString *)title withPlaceholder:(NSString *) placeholederText rightTitle:(NSString *)rightTitle
{
    
    UITextField *textField      = [[UITextField alloc]initWithFrame:rect];
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [RGBCOLOR(234, 234, 234) CGColor];
    textField.textAlignment     = NSTextAlignmentRight;
    //    textField.layer.backgroundColor = [[UIColor whiteColor]CGColor];
    textField.backgroundColor   = [UIColor whiteColor];
    textField.font              = [UIFont systemFontOfSize:13];
    textField.textColor         = [UIColor colorWithWhite:0.447 alpha:1.000];

    UILabel *leftLabel          = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, rect.size.height)];
    leftLabel.textAlignment     = NSTextAlignmentLeft;
    leftLabel.text              = [NSString stringWithFormat:@" %@",title];
    leftLabel.textColor         = RGBCOLOR(93, 93, 93);
    leftLabel.font              = [UIFont systemFontOfSize:15];

    UILabel *rightLabel         = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, rect.size.height)];
    rightLabel.textAlignment    = NSTextAlignmentCenter;
    rightLabel.text             = [NSString stringWithFormat:@"%@ ",rightTitle];
    rightLabel.textColor        = RGBCOLOR(93, 93, 93);
    rightLabel.font             = [UIFont systemFontOfSize:15];

    textField.leftView          = leftLabel;
    textField.leftViewMode      = UITextFieldViewModeAlways;
    textField.rightView         = rightLabel;
    textField.rightViewMode     = UITextFieldViewModeAlways;
    textField.clearButtonMode   = UITextFieldViewModeWhileEditing;
    //    NSDictionary *att = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12]};
    //    NSAttributedString *tempString = [[NSAttributedString alloc]initWithString:stringHolder attributes:att];
    //    textField.attributedPlaceholder = tempString;
    textField.placeholder       = placeholederText;
    return textField;
}

@end
