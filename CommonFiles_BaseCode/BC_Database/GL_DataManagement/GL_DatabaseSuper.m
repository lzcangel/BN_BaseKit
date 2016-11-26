//
//  GL_ DatabaseSuper.m
//  fmdbDemo
//
//  Created by newman on 15-2-20.
//  Copyright (c) 2015年 zhangxy. All rights reserved.
//

#import "GL_DatabaseSuper.h"
#import "GL_DatabaseSQL.h"

@implementation GL_DatabaseSuper

GL_DatabaseSuper *database = nil;
NSMutableDictionary *databaseDictionary = nil;

+ (id)returnDatabase
{
    if(database == nil)database = [[GL_DatabaseSQL alloc]init];
    database.setKey = YES;
    return database;
}

+ (id)returnDatabaseWithName:(NSString *)name
{
   if(databaseDictionary == nil)databaseDictionary = [[NSMutableDictionary alloc]init];
    GL_DatabaseSQL *dataDB = [databaseDictionary objectForKey:name];
    if(dataDB == nil)
    {
        dataDB = [[GL_DatabaseSQL alloc]initWithName:name];
    }
    dataDB.setKey = NO;
    [databaseDictionary setObject:dataDB forKey:name];
    return dataDB;
}

@end

