//
//  QJTL_BaseViewController.h
//  QJTLBaseFramework
//
//  Created by qijuntonglian on 15/3/12.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base_UITabBarBaseController.h"
#import "Base_ControlsFactory.h"
#import "Base_Common.h"

typedef void (^VCNetBlock)();

@interface Base_BaseViewController : UIViewController


#pragma mark-
#pragma mark按钮事件
-(void)buttonAction:(UIButton*)button;

#pragma mark -
#pragma mark - chuan
/***************************************************************************************************************
 * 函数名称: createButtonWithTitle:(NSString *)titleT normalImage:(NSString *)normalImage heightedImage:(NSString *)heightedImage tag:(NSInteger)tagN
 * 功能描述: 按钮初始化
 * 参    数: titleT：文字 normalImage：正常显示图片 heightedImage：高亮显示图片 tagN：标记
 * 返 回 值: UIButton
 * 其它说明: 子类实现按钮响应函数：- (void)buttonAction:(id)sender
 ****************************************************************************************************************/
- (UIButton *)createButtonWithTitle:(NSString *)titleT normalImage:(NSString *)normalImage heightedImage:(NSString *)heightedImage tag:(NSInteger)tagN;

/***************************************************************************************************************
 * 函数名称: createButtonWithTitle:(NSString *)titleT normalImage:(NSString *)normalImage heightedImage:(NSString *)heightedImage tag:(NSInteger)tagN strechParamX:(NSInteger)xParam strechParamY:(NSInteger)yParam
 * 功能描述: 带拉伸参数的按钮初始化
 * 参    数: titleT：文字 normalImage：正常显示图片 heightedImage：高亮显示图片 tagN：标记 LeftCapWidth：从x轴第几个像素开始拉伸
 TopCapHeight：从y轴第几个像素开始拉伸
 * 返 回 值: UIButton
 * 其它说明: 子类实现按钮响应函数：- (void)buttonAction:(id)sender
 ****************************************************************************************************************/
- (UIButton *)createButtonWithFrame:(CGRect)rect Image:(NSString *)image HeightLightImage:(NSString *)heightLightImage LeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight;

/***************************************************************************************************************
 * 函数名称: createLabelWithText:(NSString *)text fontSize:(CGFloat)size textAlignment:(UITextAlignment)textAlignment
 * 功能描述: label创建
 * 参    数: text：文字 rect：label大小
 * 返 回 值: UILabel
 * 其它说明:
 ****************************************************************************************************************/
- (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text;
- (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text font:(int)font;
- (UILabel *)createLabelWithText:(NSString *)text fontSize:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/***************************************************************************************************************
 * 函数名称: createTextFieldWithPlaceholder:(NSString *)text fontSize:(CGFloat)size tag:(NSInteger)kViewTag
 * 功能描述: UITextField控件创建
 * 参    数: text：文字 size：文字大小  tag：标记
 * 返 回 值: UITextField
 * 其它说明:
 ****************************************************************************************************************/
- (UITextField *)createTextFieldWithPlaceholder:(NSString *)text fontSize:(CGFloat)size tag:(NSInteger)kViewTag;

/***************************************************************************************************************
 * 函数名称: loadCustomNavigationButton
 * 功能描述: nav控件设置
 * 参    数:
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
-(void)loadCustomNavigationButton;

/***************************************************************************************************************
 * 函数名称: buildControls
 * 功能描述: 生成所有所需控件
 * 参    数:
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
- (void)buildControls;

/***************************************************************************************************************
 * 函数名称: setControlsFrame
 * 功能描述: 在刷新界面时设置控件位置
 * 参    数:
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
- (void)setControlsFrame;

/***************************************************************************************************************
 * 函数名称: loadViewControllerWithInfo:(id)info
 * 功能描述: 被通知调用时所运行的函数
 * 参    数: info:传递的信息
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
- (void)loadViewControllerWithInfo:(id)info;

/***************************************************************************************************************
 * 函数名称: setNavigationBarHidden:(BOOL)hidden
 * 功能描述: 在界面中设置导航栏状态，慎用
 * 参    数: hidden:是否隐藏
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
- (void)setNavigationBarHidden:(BOOL)hidden;

/***************************************************************************************************************
 * 函数名称: getTextFieldWithFrame:(CGRect)rect withTitle:(NSString *)title withPlaceholder:(NSString *) placeholederText
 * 功能描述: UITextField控件创建
 * 参    数: rect：控件大小 title：控件左视图文字  placeholederText：提示文字
 * 返 回 值: UITextField
 * 其它说明:
 ****************************************************************************************************************/
- (UITextField *)getTextFieldWithFrame:(CGRect)rect withTitle:(NSString *)title withPlaceholder:(NSString *) placeholederText rightTitle:(NSString *)rightTitle;

- (void)showHud:(BOOL)show;

/***************************************************************************************************************
 * 函数名称: showNocompletedHud
 * 功能描述: 未完成模块提示
 * 参    数:
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
- (void)showNoCompletedHud;

/***************************************************************************************************************
 * 函数名称: showHudPrompt:(NSString *)str
 * 功能描述: 提示语显示
 * 参    数:str 提示语
 * 返 回 值:
 * 其它说明:
 ****************************************************************************************************************/
- (void)showHudPrompt:(NSString *)str;

#pragma mark-
#pragma mark设置VC刷新方法
- (void)setRefreshBlock:(VCNetBlock)block;

#pragma mark-
#pragma mark执行VC刷新方法
- (void)refreshBlock;

@end
