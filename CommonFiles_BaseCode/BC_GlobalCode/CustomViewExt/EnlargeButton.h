//
//  EnlargeButton.h
//  BN_BaseKit
//
//  Created by Diana on 16/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  可自定义点击区域按钮
 */
@interface EnlargeButton : UIButton

/**
 *  用于修改按钮点击区域
 */
@property (nonatomic, assign) UIEdgeInsets enlargeInset;

@end
