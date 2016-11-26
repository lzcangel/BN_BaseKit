//
//  GL__DatabaseSQL.h
//  fmdbDemo
//
//  Created by newman on 15-2-20.
//  Copyright (c) 2015年 zhangxy. All rights reserved.
//

//查询最大值语句
//select * from BikeTrajectory where add_time = (select max(add_time) from BikeTrajectory)
//
//Sql Server2000支持的表级锁定提示
//
//HOLDLOCK 持有共享锁，直到整个事务完成，应该在被锁对象不需要时立即释放，等于SERIALIZABLE事务隔离级别
//
//NOLOCK 语句执行时不发出共享锁，允许脏读 ，等于 READ UNCOMMITTED事务隔离级别
//
//PAGLOCK 在使用一个表锁的地方用多个页锁
//
//READPAST 让sql server跳过任何锁定行，执行事务，适用于READ UNCOMMITTED事务隔离级别只跳过RID锁，不跳过页，区域和表锁
//
//ROWLOCK 强制使用行锁
//
//TABLOCKX 强制使用独占表级锁，这个锁在事务期间阻止任何其他事务使用这个表
//
//UPLOCK 强制在读表时使用更新而不用共享锁


#import "GL_DatabaseSuper.h"

@interface GL_DatabaseSQL : GL_DatabaseSuper

@property (nonatomic,strong)NSString *name;

- (id)initWithName:(NSString *)name;

@end
