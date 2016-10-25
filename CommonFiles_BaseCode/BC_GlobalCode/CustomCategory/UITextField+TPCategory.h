//
//  UITextField+TPCategory.h
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TPCategory)

@property(nonatomic,strong)UIDatePicker *datePicker;

- (void)shake;

-(void)setLeftImageWithImage:(NSString *)imageName;

- (void)useDateKeyboard:(NSString *)dateFormatStr;

@end
