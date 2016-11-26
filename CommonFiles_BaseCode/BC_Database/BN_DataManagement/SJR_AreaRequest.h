//
//  SJR_Area.h
//  ShiJuRen
//
//  Created by xuwk on 15/9/6.
//  Copyright (c) 2015年 qijuntonglian. All rights reserved.
//

#import "GL_requestSuper.h"

@interface SJR_AreaRequest : GL_requestSuper
@property(nonatomic,assign)int pid;
@property(nonatomic,assign)int level;
@end


@interface SJR_Area : GL_returnSuper

@property(nonatomic,assign)int ID;
@property(nonatomic,strong)NSString *CODE;
@property(nonatomic,assign)int PID;
@property(nonatomic,strong)NSString *NAME;
@property(nonatomic,assign)int LEVEL;
@property(nonatomic,assign)int ZIPCODE;
@property(nonatomic,assign)int STATE;
@property(nonatomic,strong)NSString *REMARK;
@property(nonatomic,strong)NSString *DIALLING_CODE;

/**
 *  获取下一级列表
 *
 *  @param dataBlock 回调函数
 */
- (void)getNextLevelArrayBlock:(void (^)(NSError *error,NSArray *data))dataBlock;

@end