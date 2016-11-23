//
//  BC_ToolRequest.h
//  BN_BaseKit
//
//  Created by newman on 16/10/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//刷新所有存活界面通知
#define BN_RefreshAllView @"BN_UDJRAVi_JMX546"

//用户token过期通知
#define BN_NetTokenExpiredEvent @"BN_EirAVi_J2X5s6"

typedef NS_ENUM(NSInteger, NetLoadEvent) {
    NetLoadSuccessfulEvent  = 0,//成功
    NetFailureEvent         = 1,//失败
    NetTokenExpiredEvent    = 2,//用户token无效
    NetNotCertifiedEvent    = 4,//您还未认证，请先认证
    NetUnderReviewEvent     = 10,//您的认证正在审核中，请稍等
    NetCertifiedFailedEvent = 11,//您的资料认证失败
    NetLoadingEvent         = 1001,//正在加载中
    NetLoadFailedEvent      = 1002,//网络请求失败
};

@interface BC_ToolRequest : NSObject

+(BC_ToolRequest *)sharedManager;

@property(nonatomic, copy) NSString *token;

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
