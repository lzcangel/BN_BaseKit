//
//  SJR_DataManagement.h
//  ShiJuRen
//
//  Created by qijuntonglian on 15/9/2.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GL_DatabaseSuper.h"

#import "SJR_AreaRequest.h"

@interface BN_DataManagement : NSObject

/**
 *  数据库初始化
 */
+ (void)initializeAllDataTable;

/**
 *  删除当前用户当前车辆的车辆数据
 */
+ (void)deleteAllDataWithCurrentCar;



/**
 *  获取区域列表
 *
 *  @param PID 级标
 *
 *  @return 请求实例
 */
+ (SJR_AreaRequest *)requestAreaPID:(int)PID;

@end
