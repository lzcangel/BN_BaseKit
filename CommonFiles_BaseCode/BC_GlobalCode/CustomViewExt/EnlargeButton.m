//
//  EnlargeButton.m
//  BN_BaseKit
//
//  Created by Diana on 16/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "EnlargeButton.h"

@implementation EnlargeButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat x = self.bounds.origin.x - self.enlargeInset.left;
    CGFloat y = self.bounds.origin.y - self.enlargeInset.top;
    CGFloat width = self.bounds.size.width + self.enlargeInset.right + self.enlargeInset.left;
    CGFloat height = self.bounds.size.height + self.enlargeInset.bottom + self.enlargeInset.top;
    CGRect rect = CGRectMake(x, y, width, height);
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    BOOL result = CGRectContainsPoint(rect, point) && self.hidden == NO ? YES : NO;
    return result;
}

@end
