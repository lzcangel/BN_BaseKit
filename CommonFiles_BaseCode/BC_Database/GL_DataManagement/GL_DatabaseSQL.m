//
//  GL__DatabaseSQL.m
//  fmdbDemo
//
//  Created by newman on 15-2-20.
//  Copyright (c) 2015年 zhangxy. All rights reserved.
//

#import "GL_DatabaseSQL.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface GL_DatabaseSQL ()
{
    FMDatabase *_db;
    FMDatabaseQueue *_queue;
}
@end

@implementation GL_DatabaseSQL

- (id)init {
    self = [super init];
    if (self)
    {
        [self createDatabase];
        return self;
    }
    return nil;
}

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self)
    {
        self.name = name;
        [self createDatabase];
        return self;
    }
    return nil;
}


- (void)createDatabase
{
    if(_db != nil || _queue != nil)return;
    //1.获得数据库文件的路径
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName;
        if(_name == nil)
        {
            fileName=[doc stringByAppendingPathComponent:@"SJR_sxcDB.sqlite"];
        }
        else
        {
            fileName = [NSString stringWithFormat:@"%@.db",_name];
            fileName=[doc stringByAppendingPathComponent:fileName];
            
        }
        //2.获得数据库
        _db=[FMDatabase databaseWithPath:fileName];
        _queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
//    });
}

// 打开数据库
- (void)openDatabase
{
    [_db open];
    if(self.setKey == YES)[_db setKey:GL_DatabaseKey];
    __weak GL_DatabaseSQL *temp = self;
    [_queue inDatabase:^(FMDatabase *db) {
        if(temp.setKey == YES)[db setKey:GL_DatabaseKey];
    }];
    [_db executeUpdate:@"PRAGMA foreign_keys=ON;"];
}
//关闭数据库
- (void)closeDatabase
{
    [_db close];
}


//创建表语句，子类使用
- (BOOL)createTable:(Class)table primaryKey:(NSString *)primaryKey foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey
{
    //获取数据
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(table, &outCount);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyAttributes = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        NSMutableString *propertyAttribute;
        
        NSRange range = [propertyAttributes rangeOfString:@"NSString"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"TEXT"];
        range = [propertyAttributes rangeOfString:@"Ti"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"INT"];
        range = [propertyAttributes rangeOfString:@"Tq"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"INTEGER"];
        range = [propertyAttributes rangeOfString:@"TB"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"BOOL"];
        range = [propertyAttributes rangeOfString:@"Tc"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"CHAR"];
        range = [propertyAttributes rangeOfString:@"Tf"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"FLOAT"];
        range = [propertyAttributes rangeOfString:@"Td"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"DOUBLE"];
        [dic setObject:propertyAttribute forKey:propertyName];
        
        if(primaryKey != nil && [propertyName isEqualToString:primaryKey])
        {
            [propertyAttribute appendString:@" NOT NULL PRIMARY KEY"];
        }
    }
    free(properties);
    
    NSMutableString *sqlCreateTable = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (",NSStringFromClass(table)];
    for(NSString *key in [dic allKeys])
    {
        [sqlCreateTable appendFormat:@" %@ %@,",key,[dic objectForKey:key]];
    }
    if(foreignKey != nil && foreignTable != nil)[sqlCreateTable appendFormat:@"CONSTRAINT %@ FOREIGN KEY(%@) REFERENCES %@(%@) ON DELETE CASCADE,",NSStringFromClass(table),foreignKey,foreignTable,foreignKey];
    [sqlCreateTable deleteCharactersInRange:NSMakeRange(sqlCreateTable.length-1, 1)];
    [sqlCreateTable appendFormat:@"%@",@")"];
    NSLog(@"创建表语句:%@",sqlCreateTable);
    [_db executeUpdate:@"PRAGMA foreign_keys=ON;"];
    BOOL a = [_db executeUpdate:sqlCreateTable];
    NSLog(@"创建表结果%d",a);
    return a;
}

//创建复合主键表语句
- (BOOL)createTable:(Class)table primaryKey1:(NSString *)primaryKey1 primaryKey2:(NSString *)primaryKey2 foreignTable:(NSString *)foreignTable foreignKey:(NSString *)foreignKey
{
    //获取数据
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(table, &outCount);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyAttributes = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        NSMutableString *propertyAttribute;
        
        NSRange range = [propertyAttributes rangeOfString:@"NSString"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"TEXT NOT NULL"];
        range = [propertyAttributes rangeOfString:@"Ti"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"INT NOT NULL"];
        range = [propertyAttributes rangeOfString:@"Tq"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"INTEGER NOT NULL"];
        range = [propertyAttributes rangeOfString:@"TB"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"BOOL NOT NULL"];
        range = [propertyAttributes rangeOfString:@"Tc"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"CHAR NOT NULL"];
        range = [propertyAttributes rangeOfString:@"Tf"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"FLOAT NOT NULL"];
        range = [propertyAttributes rangeOfString:@"Td"];
        if (range.length > 0)propertyAttribute=[NSMutableString stringWithFormat:@"%@",@"DOUBLE NOT NULL"];
        [dic setObject:propertyAttribute forKey:propertyName];
        
    }
    free(properties);
    
    NSMutableString *sqlCreateTable = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (",NSStringFromClass(table)];
    for(NSString *key in [dic allKeys])
    {
        [sqlCreateTable appendFormat:@" %@ %@,",key,[dic objectForKey:key]];
    }
    if(foreignKey != nil && foreignTable != nil)[sqlCreateTable appendFormat:@"CONSTRAINT %@ FOREIGN KEY(%@) REFERENCES %@(%@) ON DELETE CASCADE,",NSStringFromClass(table),foreignKey,foreignTable,foreignKey];
    if(primaryKey1 != nil && primaryKey2 != nil)[sqlCreateTable appendFormat:@"CONSTRAINT pk_PersonID PRIMARY KEY (%@,%@),",primaryKey1,primaryKey2];
    [sqlCreateTable deleteCharactersInRange:NSMakeRange(sqlCreateTable.length-1, 1)];
    [sqlCreateTable appendFormat:@"%@",@")"];
    NSLog(@"创建复合主键表语句:%@",sqlCreateTable);
    [_db executeUpdate:@"PRAGMA foreign_keys=ON;"];
    BOOL a = [_db executeUpdate:sqlCreateTable];
    NSLog(@"创建复合主键表结果%d",a);
    return a;
}


//插入语句
- (BOOL)insertDatabaseIntoTable:(NSString *)table data:(NSDictionary *)data cover:(BOOL)cover
{
    NSMutableString *insertSql;
    if(cover == YES)
    {
        insertSql = [NSMutableString stringWithFormat:@"REPLACE INTO '%@' (",table];
    }
    else
    {
        insertSql = [NSMutableString stringWithFormat:@"INSERT INTO '%@' (",table];
    }
    
    for(NSString *key in [data allKeys])
    {
        [insertSql appendFormat:@"'%@',",key];
    }
    [insertSql deleteCharactersInRange:NSMakeRange(insertSql.length-1, 1)];
    [insertSql appendString:@") VALUES ("];
    for(id value in [data allValues])
    {
        if([value isKindOfClass:[NSNumber class]])
        {
            [insertSql appendFormat:@"%@,",value];
        }
        else
        {
            [insertSql appendFormat:@"'%@',",value];
        }
    }
    [insertSql deleteCharactersInRange:NSMakeRange(insertSql.length-1, 1)];
    [insertSql appendString:@")"];
    NSLog(@"插入语句 %@",insertSql);
        //[db setKey:GL_DatabaseKey];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"PRAGMA foreign_keys=ON;"];
        [db executeUpdate:insertSql];
    }];
    return YES;
}


//删除语句 参数：table ，@"? < ?",@"? < ?"
- (BOOL)deleteDatabaseIntoTable:(NSString *)table,...
{
    NSMutableString *deleteSql = [NSMutableString stringWithFormat:@"delete from %@ where ",table];
    
    va_list args;
    va_start(args, table);
    if(table)
    {
        id nextArg;
        while((nextArg = va_arg(args, id)))
        {
            [deleteSql appendFormat:@"%@,",nextArg];
        }
        [deleteSql deleteCharactersInRange:NSMakeRange(deleteSql.length-1, 1)];
    }
    va_end(args);
    NSLog(@"删除语句 %@",deleteSql);
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"PRAGMA foreign_keys=ON;"];
        [db executeUpdate:deleteSql];
    }];
//    [_db executeUpdate:deleteSql];
    return YES;
}

//查询语句 参数：table ，@"? < ?",@"? < ?"
- (NSArray *)selectDatabaseReverseOrder:(BOOL)reverseOrder IntoTable:(NSString *)table ,...
{
    NSMutableString *selectSql = [NSMutableString stringWithFormat:@"select * from %@ where ",table];
    
    va_list args;
    va_start(args, table);
    if(table)
    {
        BOOL haveSql = NO;
        id nextArg;
        while((nextArg = va_arg(args, id)))
        {
            haveSql = YES;
            [selectSql appendFormat:@"%@ AND ",nextArg];
        }
        if(haveSql == NO)
        {
            [selectSql deleteCharactersInRange:NSMakeRange(selectSql.length-6, 6)];
        }
        else
        {
            [selectSql deleteCharactersInRange:NSMakeRange(selectSql.length-4, 4)];
        }
    }
    va_end(args);
 
    NSLog(@"查询语句 %@",selectSql);
    
    FMResultSet *resultSet;
    resultSet = [_db executeQuery:selectSql];
    // 2.遍历结果
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while ([resultSet next])
    {
        if(reverseOrder == YES)
        {
            [array insertObject:[resultSet resultDictionary] atIndex:0];
        }
        else
        {
            [array addObject:[resultSet resultDictionary]];
        }
    }
    return array;
}

//更新语句 参数：table data，@"? < ?",@"? < ?"
- (BOOL)updateDatabaseIntoTable:(NSString *)table data:(NSDictionary *)data,...
{
    NSMutableString *updateSql = [NSMutableString stringWithFormat:@"UPDATE '%@' SET ",table];
    for(NSString *key in data)
    {
        if([[data objectForKey:key] isKindOfClass:[NSNumber class]])
        {
           [updateSql appendFormat:@"'%@' = %@,",key,[data objectForKey:key]];
        }
        else
        {
           [updateSql appendFormat:@"'%@' = '%@',",key,[data objectForKey:key]];
        }
    }
    [updateSql deleteCharactersInRange:NSMakeRange(updateSql.length-1, 1)];
    [updateSql appendFormat:@" WHERE "];
    va_list args;
    va_start(args, data);
    if(table)
    {
        id nextArg;
        while((nextArg = va_arg(args, id)))
        {
            [updateSql appendFormat:@"%@ AND ",nextArg];
        }
        [updateSql deleteCharactersInRange:NSMakeRange(updateSql.length-4, 4)];
    }
    va_end(args);

    NSLog(@"更新语句 %@",updateSql);
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"PRAGMA foreign_keys=ON;"];
        [db executeUpdate:updateSql];
    }];
    return YES;
}



@end
