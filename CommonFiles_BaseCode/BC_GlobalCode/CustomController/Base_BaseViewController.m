//
//  QJTL_BaseViewController.m
//  QJTLBaseFramework
//
//  Created by qijuntonglian on 15/3/12.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "Base_UITabBarBaseController.h"
#import "Base_ControlsFactory.h"
#import "QJTL_Global.h"

@interface Base_BaseViewController ()<UITextFieldDelegate>
{
    MBProgressHUD *hud;
    VCNetBlock refreshDatablock;
}
@end

@implementation Base_BaseViewController

- (id)init {
    self = [super init];
    if (self)
    {
        return self;
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildControls];
    [self loadCustomNavigationButton];
    hud = [[MBProgressHUD alloc]initWithView:[[UIApplication sharedApplication].delegate window]];
    hud.label.text = @"加载中，请稍后...";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setControlsFrame];
    });
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.view addSubview:hud];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [(Base_UITabBarBaseController*)self.tabBarController setTabBarHidden:YES animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:IMAGE(@"") forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
   NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.0392 green:0.2 blue:0.4392 alpha:1.0],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:16],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:nil];
//    [self setControlsFrame];
//    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)loadCustomNavigationButton{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"QJTL_NavLeftBack"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    
    leftBarButton.tintColor = [UIColor colorWithRed:0.0 green:0.1176 blue:0.4549 alpha:1.0];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

//生成所有所需控件
- (void)buildControls
{
    
}

//在刷新界面时设置控件位置
- (void)setControlsFrame
{
    
}

//被通知调用时所运行的函数
- (void)loadViewControllerWithInfo:(id)info
{
    
}

//在界面中设置导航栏状态
- (void)setNavigationBarHidden:(BOOL)hidden
{
   [self.navigationController setNavigationBarHidden:hidden animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self setControlsFrame];
    }];
}


-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark-
#pragma mark菊花事件
- (void)showHud:(BOOL)show
{
    if(show == YES)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud showAnimated:YES];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }
}

#pragma mark-
#pragma mark未完成模块提示
- (void)showNoCompletedHud
{
    MBProgressHUD *noCompletedHud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:noCompletedHud];
    noCompletedHud.mode = MBProgressHUDModeText;
    noCompletedHud.detailsLabel.font = [UIFont systemFontOfSize:16];
    noCompletedHud.detailsLabel.text = @"玩命开发中，尽请期待";
    [noCompletedHud showAnimated:YES];
    [noCompletedHud hideAnimated:YES afterDelay:1];
}

#pragma mark-
#pragma mark提示语显示
- (void)showHudPrompt:(NSString *)str
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *noCompletedHud = [[MBProgressHUD alloc]initWithView:self.view];
        [[UIApplication sharedApplication].keyWindow addSubview:noCompletedHud];
        noCompletedHud.mode = MBProgressHUDModeText;
        noCompletedHud.detailsLabel.font = [UIFont systemFontOfSize:16];
        noCompletedHud.detailsLabel.text = str;
        [noCompletedHud showAnimated:YES];
        [noCompletedHud hideAnimated:YES afterDelay:1];
    });
}

#pragma mark-
#pragma mark按钮事件
-(void)buttonAction:(UIButton*)button
{
    ;
}

#pragma mark-
#pragma mark设置VC刷新方法
- (void)setRefreshBlock:(VCNetBlock)block
{
    refreshDatablock = [block copy];
}

#pragma mark-
#pragma mark执行VC刷新方法
- (void)refreshBlock
{
    if(refreshDatablock != nil)refreshDatablock();
}

#pragma mark ---------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    NSLog(@"%@已成功释放",self);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation Base_BaseViewController (BaseViewControllerCreate)

#pragma mark -
#pragma mark 常用控件创建
#pragma mark ---------------------------------------------------------------------------------------------------------------
- (UIButton *)createButtonWithTitle:(NSString *)titleT normalImage:(NSString *)normalImage heightedImage:(NSString *)heightedImage tag:(NSInteger)tagN
{
    UIButton *btn      = [Base_ControlsFactory createButtonWithTitle:titleT normalImage:normalImage heightedImage:heightedImage];
    btn.tag = tagN;
    btn.exclusiveTouch = YES;//增加按钮点击的排他属性
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIButton *)createButtonWithFrame:(CGRect)rect Image:(NSString *)image HeightLightImage:(NSString *)heightLightImage LeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight
{
    UIButton *btn      = [Base_ControlsFactory createButtonWithFrame:rect Image:image HeightLightImage:heightLightImage LeftCapWidth:leftCapWidth TopCapHeight:topCapHeight];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text
{
    UILabel *label     = [Base_ControlsFactory createLabelWithFrame:rect text:text];
    return label;
}

- (UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text font:(int)font
{
    UILabel *label     = [Base_ControlsFactory createLabelWithFrame:rect text:text font:font];
    return label;
}

- (UILabel *)createLabelWithText:(NSString *)text fontSize:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [Base_ControlsFactory createLabelWithFrame:CGRectZero text:text font:size];
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    return label;
}

- (UITextField *)createTextFieldWithPlaceholder:(NSString *)text fontSize:(CGFloat)size tag:(NSInteger)kViewTag
{
    UITextField *textFieldRounded = [Base_ControlsFactory createTextFieldWithPlaceholder:text fontSize:size tag:kViewTag];
    textFieldRounded.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
    return textFieldRounded;
}

- (UITextField *)getTextFieldWithFrame:(CGRect)rect withTitle:(NSString *)title withPlaceholder:(NSString *) placeholederText rightTitle:(NSString *)rightTitle
{
    UITextField *textField = [Base_ControlsFactory getTextFieldWithFrame:rect withTitle:title withPlaceholder:placeholederText rightTitle:rightTitle];
    return textField;
}

@end
