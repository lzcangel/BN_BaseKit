//
//  BN_MapView.h
//  BN_BaseKit
//
//  Created by 许为锴 on 2016/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_MapView : UIView

- (void)andAnnotationLatitude:(CGFloat)latitude longitude:(CGFloat)longitude;

- (void)removeAllAnnotation;

- (void)setDelta:(CGFloat)Delta Latitude:(CGFloat)latitude longitude:(CGFloat)longitude;

@end
