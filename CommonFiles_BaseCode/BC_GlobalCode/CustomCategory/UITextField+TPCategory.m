//
//  UITextField+TPCategory.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "UITextField+TPCategory.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import"Base_Common.h"

@interface UITextField()

@property (nonatomic, strong)NSString *dateFormatStr;

@end

@implementation UITextField (TPCategory)

- (void)useDateKeyboard:(NSString *)dateFormatStr
{
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 260)];
    self.datePicker.minimumDate    = [NSDate date];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(timerChange:) forControlEvents:UIControlEventValueChanged];
    self.datePicker.date = [NSDate dateWithTimeIntervalSinceNow:7 * 3600 * 24];
    self.dateFormatStr = dateFormatStr?:@"yyyy-MM-dd";
    self.inputView = self.datePicker;
}

- (NSNumber *)datePicker {
    return objc_getAssociatedObject(self, @selector(datePicker));
}

- (void)setDatePicker:(UIDatePicker *)value {
    objc_setAssociatedObject(self, @selector(datePicker), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)dateFormatStr {
    return objc_getAssociatedObject(self, @selector(dateFormatStr));
}

- (void)setDateFormatStr:(UIDatePicker *)value {
    objc_setAssociatedObject(self, @selector(dateFormatStr), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)shake {
    CAKeyframeAnimation *animationKey = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animationKey setDuration:0.5f];
    
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [animationKey setValues:array];
    //[array release];
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [animationKey setKeyTimes:times];
    //[times release];
    [self.layer addAnimation:animationKey forKey:@"TextFieldShake"];
}
-(void)setLeftImageWithImage:(NSString *)imageName{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    UIImageView *leftViewImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    leftViewImage.center = leftView.center;
    [leftView addSubview:leftViewImage];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - UIDatePicker

- (void)timerChange:(UIDatePicker *)picker
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:self.dateFormatStr];
    
    NSString *str = [dateFormat stringFromDate:picker.date];
    
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if ( [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(0,str.length) replacementString:str] )
        {
            self.text = [dateFormat stringFromDate:picker.date];
            [self sendActionsForControlEvents:UIControlEventAllEditingEvents];
        }
    }
    else
    {
        self.text = [dateFormat stringFromDate:picker.date];
        [self sendActionsForControlEvents:UIControlEventAllEditingEvents];
    }
}

@end
