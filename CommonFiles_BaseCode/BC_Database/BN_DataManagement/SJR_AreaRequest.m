//
//  SJR_Area.m
//  ShiJuRen
//
//  Created by xuwk on 15/9/6.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "SJR_AreaRequest.h"
#import "BN_DataManagement.h"

@implementation SJR_AreaRequest

//用于绑定请求与结果的关系，为子类必须实现方法
- (Class)RequestToDataClass
{
    return SJR_Area.class;
}

- (void)dataRequestReadEvents:(GL_dataRequestEvents)requestEvents dataBlock:(void (^)(NSError *, NSArray *))dataBlock
{
    [super dataRequestReadEvents:requestEvents dataBlock:^(NSError *error, NSArray *data) {
        dataBlock(error,data);
    }];
}


//获取本地数据,由于各子类获取本地数据条件不同，各子类自行实现
- (NSArray *)databaseRequest
{
    NSArray *dataArray = [[GL_DatabaseSuper returnDatabaseWithName:@"SJR_AreaDBLite"] selectDatabaseReverseOrder:NO IntoTable:NSStringFromClass(self.RequestToDataClass),[NSString stringWithFormat:@"PID == %d",_pid],nil];
    NSLog(@"从数据库获取的数据如下 << %@ >>",dataArray);
    return dataArray;
}


//判断本地数据是否可用，各子类自行实现
- (BOOL)datacaseCanUse:(NSArray *)data
{
    NSLog(@"本地获取的数据为: << %@ >>",data);
    NSLog(@"本地数据不可用");
    return YES;
}

/**
 *  判断网络保存的数据是否需要保存本地，默认为YES，如有不同需重写
 */
- (BOOL)networkDataCanSave:(NSArray *)data
{
    return NO;
}

- (NSString *)url
{
    return [NSString stringWithFormat:@"%@/consumer/homePage/searchStoneDeparture",BN_BASEURL];
}

/**
 *  对网络下发数据的解析方法，默认为[dic objectForKey:@"data"]，如有不同需重写
 */
- (NSArray *)parsingNetworkData:(NSDictionary*)dic
{
    NSArray *dataArray = [dic objectForKey:@"rows"];
    NSMutableArray *returnDataArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dataDic in dataArray)
    {
        NSNumber *areaId = [dataDic objectForKey:@"areaId"];
        NSString *areaName = [dataDic objectForKey:@"areaName"];
        NSDictionary *returnDic = @{@"ID":areaId,@"NAME":areaName,@"CODE":[NSString stringWithFormat:@"%@",areaId]};
        [returnDataArray addObject:returnDic];

    }
    NSLog(@"获取到的数据为%@",returnDataArray);
    return returnDataArray;
}

@end


@implementation SJR_Area

+ (void)createTable
{
    [self createTablePrimaryKey:@"id" foreignTable:nil foreignKey:nil];
    NSLog(@"已创建车辆列表");
}

+ (NSString *)DBName
{
    return @"SJR_AreaDBLite";
}

/**
 *  获取下一级列表
 *
 *  @param dataBlock 回调函数
 */
- (void)getNextLevelArrayBlock:(void (^)(NSError *error,NSArray *data))dataBlock
{
    SJR_AreaRequest *areaRequest = [BN_DataManagement requestAreaPID:self.CODE.intValue];
    [areaRequest dataRequestReadEvents:GL_dataRequestOnlyReadLocal dataBlock:^(NSError *error, NSArray *data) {
        dataBlock(error,data);
    }];
}

- (void)dealloc
{
    NSLog(@"释放");
}

@end
