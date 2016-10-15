//
//  UILabel+TPCategory.m
//  CheGuLu
//
//  Created by qijuntonglian on 15/4/27.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "UILabel+TPCategory.h"

@implementation UILabel_TPCategory

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.text];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [text addAttribute:NSFontAttributeName value:font range:range];
    [self setAttributedText:text];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
