//
//  GL_DataManagement.h
//  SQLiteTry
//
//  Created by qijuntonglian on 15/2/28.
//  Copyright (c) 2015年 newman. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CarInfoDataRequest.h"
//#import "ShowDLinePointRequest.h"
#import "GL_DatabaseSuper.h"
//#import "CarTripRequest.h"
//#import "CarTrajectoryRequest.h"
//#import "SMSMessageRequest.h"

/**
 *  数据库初始化
 */
@interface GL_DataManagement : NSObject

+ (void)initializeAllDataTable;

///**
// *  获取车辆infoRequest
// */
//+ (CarInfoDataRequest *)requestCarInfo;
//
///**
// *  获取秀D线Request
// */
//+ (ShowDLinePointRequest *)requestShowDLinePointCarIdIs:(int)requestCarId DateIs:(int)requestDate;
//
///**
// *  获取车辆行程Request
// */
//+ (CarTripRequest *)requestCarTripEventsCarIdIs:(int)requestCarId TripDateIs:(int)requestTripDate;
//
///**
// *  获取车辆轨迹Request
// */
//+ (CarTrajectoryRequest *)requestCarTrajectoryEventsCarIdIs:(int)requestCarId startTimeIs:(int)requestStartTime end_timeIs:(int)requestEndTime;
//
///**
// *  获取消息Request
// */
//+ (SMSMessageRequest *)requestSMSMessagePIs:(int)p numIs:(int)num;

@end
