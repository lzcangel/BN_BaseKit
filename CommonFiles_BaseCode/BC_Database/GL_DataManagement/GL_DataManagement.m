//
//  GL_DataManagement.m
//  SQLiteTry
//
//  Created by qijuntonglian on 15/2/28.
//  Copyright (c) 2015年 newman. All rights reserved.
//

#import "GL_DataManagement.h"


@implementation GL_DataManagement

+ (void)load
{
    ;
}

+ (void)initializeAllDataTable
{
    [[GL_DatabaseSuper returnDatabase] openDatabase];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [CarInfoData createTable];
//        [ShowDLinePoint createTable];
//        [CarTrip createTable];
//        [CarTrajectory createTable];
//        [SMSMessage createTable];
//        
//        [[GL_DatabaseSuper returnDatabase] closeDatabase];
//        [[GL_DatabaseSuper returnDatabase] openDatabase];
//        
//        [ShowDLinePoint deleteOldData];
//        [CarTrajectory deleteOldData];
    });
}

///**
// *  获取车辆info
// */
//+ (CarInfoDataRequest *)requestCarInfo
//{
//    CarInfoDataRequest *carInfoDataRequest = [[CarInfoDataRequest alloc]init];
//    carInfoDataRequest.c = @"car";
//    carInfoDataRequest.a = @"lists";
//    carInfoDataRequest.t = [[Tool getCurrentTimeStamp] intValue];
//    carInfoDataRequest.access_token = [UserInfo sharedUserInfo].userAccess_token;
//    carInfoDataRequest.app_key = kAPP_KEY;
//    return carInfoDataRequest;
//}
//
///**
// *  获取秀D线
// */
//+ (ShowDLinePointRequest *)requestShowDLinePointCarIdIs:(int)requestCarId DateIs:(int)requestDate
//{
//    ShowDLinePointRequest *showDLinePointRequest = [[ShowDLinePointRequest alloc]init];
//    showDLinePointRequest.c = @"driving";
//    showDLinePointRequest.a = @"lists";
//    showDLinePointRequest.t = [[Tool getCurrentTimeStamp] intValue];
//    showDLinePointRequest.access_token = [UserInfo sharedUserInfo].userAccess_token;
//    showDLinePointRequest.app_key = kAPP_KEY;
//    showDLinePointRequest.car_id = [UserInfo sharedUserInfo].car_id;
//    showDLinePointRequest.date = requestDate;
//    return showDLinePointRequest;
//}
//
///**
// *  获取车辆行程
// */
//+ (CarTripRequest *)requestCarTripEventsCarIdIs:(int)requestCarId TripDateIs:(int)requestTripDate
//{
//    CarTripRequest *carTripRequest = [[CarTripRequest alloc]init];
//    carTripRequest.c = @"car";
//    carTripRequest.a = @"trip";
//    carTripRequest.t = [[Tool getCurrentTimeStamp] intValue];
//    carTripRequest.access_token = [UserInfo sharedUserInfo].userAccess_token;
//    carTripRequest.app_key = kAPP_KEY;
//    carTripRequest.car_id = [UserInfo sharedUserInfo].car_id;
//    carTripRequest.trip_date = requestTripDate;
//    return carTripRequest;
//}
//
///**
// *  获取车辆轨迹
// */
//+ (CarTrajectoryRequest *)requestCarTrajectoryEventsCarIdIs:(int)requestCarId startTimeIs:(int)requestStartTime end_timeIs:(int)requestEndTime
//{
//    CarTrajectoryRequest *carTrajectoryRequest = [[CarTrajectoryRequest alloc]init];
//    carTrajectoryRequest.c = @"car";
//    carTrajectoryRequest.a = @"track";
//    carTrajectoryRequest.t = [[Tool getCurrentTimeStamp]intValue];
//    carTrajectoryRequest.access_token = [UserInfo sharedUserInfo].userAccess_token;
//    carTrajectoryRequest.app_key = kAPP_KEY;
//    carTrajectoryRequest.car_id = [UserInfo sharedUserInfo].car_id;
//    carTrajectoryRequest.start_time = requestStartTime;
//    carTrajectoryRequest.end_time = requestEndTime;
//    return carTrajectoryRequest;
//}
//
//
//+ (SMSMessageRequest *)requestSMSMessagePIs:(int)p numIs:(int)num
//{
//    SMSMessageRequest *messageRequest = [[SMSMessageRequest alloc]init];
//    messageRequest.c = @"message";
//    messageRequest.a = @"lists";
//    messageRequest.t = [[Tool getCurrentTimeStamp] intValue];
//    messageRequest.access_token = [UserInfo sharedUserInfo].userAccess_token;
//    messageRequest.app_key = kAPP_KEY;
//    messageRequest.p = p;
//    messageRequest.num = num;
//    messageRequest.user_id = [[UserInfo sharedUserInfo].user_id intValue];
//    return messageRequest;
//}

@end
