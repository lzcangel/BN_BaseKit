//
//  GL_requestSuper.m
//  SQLiteTry
//
//  Created by qijuntonglian on 15/2/17.
//  Copyright (c) 2015年 newman. All rights reserved.
//

#import "GL_requestSuper.h"
#import "GL_DatabaseSuper.h"
#import "Base_Common.h"
#import "BC_ToolRequest.h"
#import <objc/runtime.h>
#import <MJExtension/MJExtension.h>

@interface GL_requestSuper()
{
@private
    NSArray *GL_requestData;
    Class GL_dataClass;
}

@end

@implementation GL_requestSuper

- (id)init {
    self = [super init];
    if (self)
    {
        GL_requestData = @[@"q",@"v"];
        GL_dataClass = [self RequestToDataClass];
        return self;
    }
    return nil;
}


#pragma mark -
#pragma mark subClass Methods

- (Class)RequestToDataClass
{
    NSLog(@"ERROR:子类未实现RequestToDataClass方法");
    return nil;
}

/**
 *  获取本地数据,由于各子类获取本地数据条件不同，各子类自行实现,默认为nil
 */
- (NSArray *)databaseRequest
{
    NSLog(@"ERROR:子类未实现databaseRequest方法");
    return nil;
}

/**
 *  判断本地数据是否可用，各子类自行实现,默认为YES
 */
- (BOOL)datacaseCanUse:(NSArray *)data
{
    NSLog(@"ERROR:子类未实现datacaseCanUse方法");
    return YES;
}

/**
 *  对网络下发数据的解析方法，默认为[dic objectForKey:@"data"]，如有不同需重写
 */
- (NSArray *)parsingNetworkData:(NSDictionary*)dic
{
    NSArray *dataArray = [dic objectForKey:@"data"];
    return dataArray;
}

/**
 *  判断网络保存的数据是否需要保存本地，默认为YES，如有不同需重写
 */
- (BOOL)networkDataCanSave:(NSArray *)data
{
    return YES;
}


#pragma mark -
#pragma mark selfClass Methods
/**
 *  发起数据请求，对外调用方法
 */
- (void)dataRequestReadEvents:(GL_dataRequestEvents)requestEvents dataBlock:(void (^)(NSError *error,NSArray *data))dataBlock
{
    NSLog(@"requestEvents == %lu",requestEvents);
    if(requestEvents == GL_dataRequestFirstReadLocal)
    {
        GL_requestData = [self createModelDataFromDic:[self databaseRequest]];
        if([self datacaseCanUse:GL_requestData])
        {
//            NSLog(@"经判断，本地数据可用");
            dataBlock(nil,GL_requestData);
        }
        else
        {
//            NSLog(@"经判断，本地数据不可用");
            [self internetRequest:^(NSError *error, NSArray *data) {
                dataBlock(error,data);
            }];
        }
        
    }
    else if (requestEvents == GL_dataRequestFirstReadInternet)
    {
        [self internetRequest:^(NSError *error, NSArray *data) {
            if(data != nil && data.count != 0)
            {
                NSLog(@"%lu",(unsigned long)data.count);
                dataBlock(error,data);
            }
            else
            {
                GL_requestData = [self createModelDataFromDic:[self databaseRequest]];
                dataBlock(nil,GL_requestData);
            }
        }];
    }
    else if(requestEvents == GL_dataRequestOnlyReadLocal)
    {
        GL_requestData = [self createModelDataFromDic:[self databaseRequest]];
        dataBlock(nil,GL_requestData);
    }
    else if(requestEvents == GL_dataRequestOnlyReadInternet)
    {
        [self internetRequest:^(NSError *error, NSArray *data) {
            dataBlock(error,data);
        }];
    }
}


- (void)internetRequest:(void (^)(NSError *error,NSArray *data))internetDataBlock
{
    NSDictionary *dic = [self mj_keyValues];
    NSLog(@"网络请求为%@",dic);
    
    [[BC_ToolRequest sharedManager] GET:[self url] parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"成功  %@",dic);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            internetDataBlock([NSError errorWithDomain:errorStr
                                                  code:codeNumber.intValue
                                              userInfo:nil],nil);
            return ;
        }
        NSArray *dataArray = [self parsingNetworkData:dic];
        NSLog(@"网络获取的数据为:%@",dataArray);
        
        
        NSArray *returnData = [self createModelDataFromDic:dataArray];
        //        NSLog(@"保存数据");
        if([self networkDataCanSave:returnData])
        {
            for(GL_returnSuper *dataDic in returnData)
            {
                [dataDic insertDatabaseIntoTable];
            }
        }
        internetDataBlock(nil,returnData);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"网络请求失败%@",error);
        internetDataBlock(error,nil);

    }];
    

//    [[BC_ToolRequest sharedManager] GET:[self url] parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
//    
//        NSDictionary *dic = responseObject;
////        if(dic != nil && [[dic objectForKey:@"result"] isEqualToString:@"FAIL"])
////        {
////            NSLog(@"网络请求失败为:%@",dic);
////            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Network request failed" forKey:NSLocalizedDescriptionKey];
////            NSError *error = [NSError errorWithDomain:@"" code:1 userInfo:userInfo];
////            internetDataBlock(error,nil);
////            
////            if([[dic objectForKey:@"error_code"] isEqualToString:@"1003"] || [[dic objectForKey:@"error_code"] isEqualToString:@"1004"] || [[dic objectForKey:@"error_code"] isEqualToString:@"1005"] )
////            {
////                NSString *errorStr = [dic objectForKey:@"error_msg"];
////                [ToolRequest showErrorCode:errorStr  code:[[dic objectForKey:@"error_code"] intValue]];
////            }
////            return;
////        }
//        NSNumber *codeNumber = [dic objectForKey:@"code"];
//        if(codeNumber.intValue == 0)
//        {
//            NSLog(@"成功  %@",dic);
//        }
//        else
//        {
//            NSString *errorStr = [dic objectForKey:@"remark"];
//            internetDataBlock([NSError errorWithDomain:errorStr
//                                                  code:codeNumber.intValue
//                                              userInfo:nil],nil);
//            return ;
//        }
//        NSArray *dataArray = [self parsingNetworkData:dic];
//        NSLog(@"网络获取的数据为:%@",dataArray);
//        
//    
//        NSArray *returnData = [self createModelDataFromDic:dataArray];
////        NSLog(@"保存数据");
//        if([self networkDataCanSave:returnData])
//        {
//            for(GL_returnSuper *dataDic in returnData)
//            {
//                [dataDic insertDatabaseIntoTable];
//            }
//        }
//        internetDataBlock(nil,returnData);
//    
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        NSLog(@"网络请求失败%@",error);
//        internetDataBlock(error,nil);
//    }];
}

- (NSString *)url
{
    return BN_BASEURL;
}

- (NSArray *)createModelDataFromDic:(NSArray *)array
{
    
    NSMutableArray *dataReturn = [[NSMutableArray alloc]init];
    NSDictionary *requestDic = [self mj_keyValues];
    for(NSDictionary *dataDic in array)
    {
        NSMutableDictionary *returnDic = [[NSMutableDictionary alloc]init];
        [returnDic setValuesForKeysWithDictionary:dataDic];
        [returnDic setValuesForKeysWithDictionary:requestDic];

        GL_returnSuper *data = [GL_dataClass mj_objectWithKeyValues:returnDic];
        [dataReturn addObject:data];
    }
    return dataReturn;
}


@end



@implementation GL_returnSuper

- (id)init {
    self = [super init];
    if (self)
    {
        return self;
    }
    return nil;
}

+ (void)createTable
{
    NSLog(@"ERROR:%@子类未实现createTable方法",self.class);
}

+ (NSString *)DBName
{
    return nil;
}

//清除过期数据
+ (void)deleteOldData
{
    NSLog(@"ERROR:%@子类未实现deleteOldData方法",self.class);
    ;
}

//结果实例将自身插入数据库
- (BOOL)insertDatabaseIntoTable
{
    NSDictionary *data = [self mj_keyValues];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if([self.class DBName] == nil)
        {
            [[GL_DatabaseSuper returnDatabase] insertDatabaseIntoTable:NSStringFromClass(self.class) data:data cover:NO];
        }
        else
        {
            [[GL_DatabaseSuper returnDatabaseWithName:[self.class DBName]] insertDatabaseIntoTable:NSStringFromClass(self.class) data:data cover:NO];
        }
    });
    return YES;
}

- (BOOL)updateDatabaseIntoTable
{
    NSDictionary *data = [self mj_keyValues];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if([self.class DBName] == nil)
        {
            [[GL_DatabaseSuper returnDatabase] insertDatabaseIntoTable:NSStringFromClass(self.class) data:data cover:YES];
        }
        else
        {
            [[GL_DatabaseSuper returnDatabaseWithName:[self.class DBName]] insertDatabaseIntoTable:NSStringFromClass(self.class) data:data cover:YES];
        }
    });
    return YES;
}

- (BOOL)deleleDataIntoTabel:(NSString *)sql
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if([self.class DBName] == nil)
        {
            
        }
        else
        {
            
        }
        [[GL_DatabaseSuper returnDatabase] deleteDatabaseIntoTable:NSStringFromClass(self.class),sql,nil];
    });
    return YES;
}

//类创建复合自身结构的数据库
+ (void)createTablePrimaryKey:(NSString *)primaryKey foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey
{
    if([self.class DBName] == nil)
    {
        [[GL_DatabaseSuper returnDatabase] createTable:self primaryKey:primaryKey foreignTable:foreignTable foreignKey:foreignKey];
    }
    else
    {
        [[GL_DatabaseSuper returnDatabaseWithName:[self.class DBName]] createTable:self primaryKey:primaryKey foreignTable:foreignTable foreignKey:foreignKey];
    }
}


+ (void)createTablePrimaryKey1:(NSString *)primaryKey1 primaryKey2:(NSString *)primaryKey2 foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey
{
    if([self.class DBName] == nil)
    {
        [[GL_DatabaseSuper returnDatabase] createTable:self primaryKey1:primaryKey1 primaryKey2:primaryKey2 foreignTable:foreignTable foreignKey:foreignKey];
    }
    else
    {
        [[GL_DatabaseSuper returnDatabaseWithName:[self.class DBName]] createTable:self primaryKey1:primaryKey1 primaryKey2:primaryKey2 foreignTable:foreignTable foreignKey:foreignKey];
    }
}



@end

