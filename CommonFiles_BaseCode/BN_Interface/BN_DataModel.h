//
//  BN_DataModel.h
//  BN_BaseKit
//
//  Created by newman on 16/11/14.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//
#import "BN_LoadSupport.h"

@protocol BN_DataModel <NSObject>
@required
@property(nonatomic,strong)BN_LoadSupport *loadSupport;

@end
