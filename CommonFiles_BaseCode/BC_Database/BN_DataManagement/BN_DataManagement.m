//
//  SJR_DataManagement.m
//  ShiJuRen
//
//  Created by qijuntonglian on 15/9/2.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "BN_DataManagement.h"
#import "SDImageCache.h"

@implementation BN_DataManagement

+ (void)load
{
    [BN_DataManagement initializeAllDataTable];
}

+ (void)initializeAllDataTable
{
    
    [[GL_DatabaseSuper returnDatabase] openDatabase];
    [self createProvincesDB];
//    [[GL_DatabaseSuper returnDatabaseWithName:@"SJR_ProvincesDB"] openDatabase];
    [[GL_DatabaseSuper returnDatabaseWithName:@"SJR_AreaDBLite"] openDatabase];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [areas createTable];
//        [cities createTable];
//        [provinces createTable];
//        [zipcode createTable];
//        [CGL_carTrajectory createTable];
//        [SMSMessage createTable];
//        
//        [[GL_DatabaseSuper returnDatabase] closeDatabase];
//        [[GL_DatabaseSuper returnDatabase] openDatabase];
//        
//        [CGL_carTripDay deleteOldData];
//        [CGL_carTrip deleteOldData];
    });
}

+ (void)deleteAllDataWithCurrentCar
{
    [[SDImageCache sharedImageCache] getSize];
}

+ (BOOL)createProvincesDB
{
    //目标路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"SJR_AreaDBLite.db"];
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"SJR_AreaDBLite" ofType:@"db"];

//    if([[NSFileManager defaultManager] fileExistsAtPath:sqlFilePath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
//    {
        [[NSFileManager defaultManager] removeItemAtPath:sqlFilePath error:nil];
        NSError *err = nil;
        if([[NSFileManager defaultManager] copyItemAtPath:orignFilePath toPath:sqlFilePath error:&err] == NO)//如果拷贝失败
        {
            NSLog(@"open database error %@",[err localizedDescription]);
            return NO;
        }
//    }
    return YES;
}



/**
 *  获取区域列表
 *
 *  @param PID 级标
 *
 *  @return 请求实例
 */
+ (SJR_AreaRequest *)requestAreaPID:(int)PID
{
    SJR_AreaRequest *request = [[SJR_AreaRequest alloc]init];
    request.pid = PID;
    return request;
}


@end
