//
//  BC_ToolRequest.h
//  BN_BaseKit
//
//  Created by newman on 16/10/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface BC_ToolRequest : NSObject

+(BC_ToolRequest *)sharedManager;

/**
 网络请求GET

 @param URLString  url
 @param parameters 参数
 */
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/**
 网络请求POST
 
 @param URLString  url
 @param parameters 参数
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/**
 网络请求PUT
 
 @param URLString  url
 @param parameters 参数
 */
- (void)PUT:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/**
 网络请求DELETE
 
 @param URLString  url
 @param parameters 参数
 */
- (void)DELETE:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  上传文件并获取地址
 *
 *  @param dataList  文件列表
 *  @param nameList  文件名，可为空
 *  @param dataBlock 结果回调
 */
- (void)uploadfile:(NSArray *)dataList fileName:(NSArray *)nameList block:(void (^)(NSArray *files, NSError *error))dataBlock;

@end
