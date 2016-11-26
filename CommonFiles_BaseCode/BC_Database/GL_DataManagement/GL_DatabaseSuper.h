//
//  GL_ DatabaseSuper.h
//  fmdbDemo
//
//  Created by newman on 15-2-20.
//  Copyright (c) 2015年 zhangxy. All rights reserved.
//

#define GL_DatabaseKey @"12345675" //钥匙串

#import <Foundation/Foundation.h>

@interface GL_DatabaseSuper : NSObject

@property (nonatomic,assign)BOOL setKey;

/**
 *  返回数据库管理类
 */
+ (id)returnDatabase;

/**
 *  根据表名返回数据库管理类
 *
 *  @return self
 */
+ (id)returnDatabaseWithName:(NSString *)name;

/**
 *  打开数据库
 */
- (void)openDatabase;

/**
 *  关闭数据库
 */
- (void)closeDatabase;


/**
 *  创建表语句，子类使用
 */
- (BOOL)createTable:(Class)table primaryKey:(NSString *)primaryKey foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey;


/**
 *  创建复合主键表语句，子类使用
 */
- (BOOL)createTable:(Class)table primaryKey1:(NSString *)primaryKey1 primaryKey2:(NSString *)primaryKey2 foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey;


/**
 *  插入语句
 */
- (BOOL)insertDatabaseIntoTable:(NSString *)table data:(NSDictionary *)data cover:(BOOL)cover;


/**
 *  删除语句 参数：table ，@"? < ?",@"? < ?"
 */
- (BOOL)deleteDatabaseIntoTable:(NSString *)table,...;


/**
 *  查询语句 参数：table ，@"? < ?",@"? < ?"
 */
- (NSArray *)selectDatabaseReverseOrder:(BOOL)reverseOrder IntoTable:(NSString *)table ,...;


/**
 *  更新语句 参数：table data，@"? < ?",@"? < ?"
 */
- (BOOL)updateDatabaseIntoTable:(NSString *)table data:(NSDictionary *)data,...;


@end
