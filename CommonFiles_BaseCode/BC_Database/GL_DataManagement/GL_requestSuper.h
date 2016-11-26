//
//  GL_requestSuper.h
//  SQLiteTry
//
//  Created by qijuntonglian on 15/2/17.
//  Copyright (c) 2015年 newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GL_DatabaseSuper.h"

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

typedef NS_OPTIONS(NSUInteger, GL_dataRequestEvents) {
    GL_dataRequestFirstReadLocal       = 0,
    GL_dataRequestFirstReadInternet    = 1,
    GL_dataRequestOnlyReadLocal        = 2,
    GL_dataRequestOnlyReadInternet     = 3
};

//首先，根据条件判断本地是否有符合条件的数据
//如果本地存在数据并且本地数据可用，则采用本地数据返回
//如果本地数据为空或者不可用，则向网络发起数据请求
//网络返回数据后，处理并放入本地数据库
//返回数据库中数据

@interface GL_requestSuper : NSObject
{
//   @private
//      NSArray *requestData;
//    Class dataClass;
}

@property(nonatomic,strong)NSString *c;
@property(nonatomic,strong)NSString *a;
@property(nonatomic,strong)NSString *access_token;
@property(nonatomic,strong)NSString *app_key;
@property(nonatomic,assign)int t;

/**
 *  发起数据请求，对外调用方法
 *  输入参数: requestEvents:请求逻辑  dataBlock：回调block
 *   返回值:
 */
- (void)dataRequestReadEvents:(GL_dataRequestEvents)requestEvents dataBlock:(void (^)(NSError *error,NSArray *data))dataBlock;


/**
 *  本方法为子类实现方法
 *  用于绑定请求与结果的关系，为子类必须实现方法
 *  输入参数:
 *   返回值:
 */
- (Class)RequestToDataClass;

/**
 *  返回请求的url，子类重写
 */
- (NSString *)url;

/**
 *  本方法为子类实现方法
 *  获取本地数据,由于各子类获取本地数据条件不同，各子类自行实现,默认为nil
 *  输入参数:
 *   返回值: DB请求数据
 */
- (NSArray *)databaseRequest;

/**
 *  本方法为子类实现方法
 *  判断本地数据是否可用，各子类自行实现,默认为YES
 *  输入参数: data:DB获得的数据
 *   返回值: 是否可用
 */
- (BOOL)datacaseCanUse:(NSArray *)data;

/**
 *  本方法为子类实现方法
 *  对网络下发数据的解析方法，默认为[dic objectForKey:@"data"]，如有不同需重写
 *  输入参数: dic:网络获取的数据字典
 *   返回值: 数据字典
 */
- (NSArray *)parsingNetworkData:(NSDictionary*)dic;

/**
 *  判断网络保存的数据是否需要保存本地，默认为YES，如有不同需重写
 */
- (BOOL)networkDataCanSave:(NSArray *)data;

@end



@interface GL_returnSuper : NSObject

/**
 *  本方法为子类实现方法
 *  创建自身表结构，子类实现,必须实现
 */
+ (void)createTable;

/**
 *  返回对应的数据库名字，子类重写
 *
 *  @return 数据库名字
 */
+ (NSString *)DBName;

/**
 *  本方法为子类实现方法
 *  清除过期数据
 */
+ (void)deleteOldData;

/**
 *  类创建自身结构的数据库,提供给子类使用
 */
+ (void)createTablePrimaryKey:(NSString *)primaryKey foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey;

/**
 *  类创建复合自身结构的数据库,提供给子类使用
 */
+ (void)createTablePrimaryKey1:(NSString *)primaryKey1 primaryKey2:(NSString *)primaryKey2 foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey;

/**
 *  插入语句,调用后将本身数据插入数据库    //已完成
 */
- (BOOL)insertDatabaseIntoTable;

/**
 *  更新语句 参数：table data，@"? < ?",@"? < ?"  //未完成
 */
- (BOOL)updateDatabaseIntoTable;


/**
 *  删除语句   //已完成
 */
- (BOOL)deleleDataIntoTabel:(NSString *)sql;

@end


