//
//  BC_ToolRequest.m
//  BN_BaseKit
//
//  Created by newman on 16/10/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BC_ToolRequest.h"
#import "QJTL_Global.h"
#import <QiniuSDK.h>

@interface BC_ToolRequest ()<MBProgressHUDDelegate>
{
    MBProgressHUD *hud;
    MBProgressHUD *downloadHUD;
    float _upLoadProgress;
}
@property(nonatomic, assign)NSInteger requestCount;
@end

@implementation BC_ToolRequest

static BC_ToolRequest *toolRequest = nil;

@synthesize token = _token;

+(BC_ToolRequest *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolRequest = [[BC_ToolRequest alloc]init];
    });
    return toolRequest;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    hud = [[MBProgressHUD alloc]initWithView:[[UIApplication sharedApplication].delegate window]];
    hud.label.text = @"加载中，请稍后...";
    self.requestCount = 0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
    });
    
    [RACObserve(self, requestCount) subscribeNext:^(NSNumber *value) {
        if (value.integerValue <= 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud showAnimated:YES];
            });
        }
    }];
    
    return self;
}

- (void)setToken:(NSString *)token
{
    _token = token;
    if (_token && [_token length]) {
        [[NSUserDefaults standardUserDefaults] setObject:_token forKey:@"LocalToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LocalToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString*)token
{
    if (!_token) {
        _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalToken"];
    }
    return _token;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (toolRequest == nil)
        {
            toolRequest = [super allocWithZone:zone];
            return toolRequest;
        }
    }
    return nil;
}

//网络请求数据
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    self.requestCount ++;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    if (self.token && [self.token length]) {
        [manager.requestSerializer setValue:self.token forHTTPHeaderField:@"Token"];
    }
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
        self.requestCount --;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
        self.requestCount --;
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSData *sendData = nil;
    if (parameters) {
        sendData = [NSJSONSerialization dataWithJSONObject:parameters
                                        options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:nil error:nil];
    if (self.token && [self.token length]) {
        [req setValue:self.token forHTTPHeaderField:@"Token"];
    }
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:sendData];
    
    self.requestCount ++;
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            success(nil,responseObject);
            self.requestCount --;
            NSLog(@"Reply JSON: %@", responseObject);
        } else {
            failure(nil,error);
            self.requestCount --;
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
}

- (void)PUT:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSData *sendData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:URLString parameters:nil error:nil];
    if (self.token && [self.token length]) {
        [req setValue:self.token forHTTPHeaderField:@"Token"];
    }
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:sendData];
    
    self.requestCount ++;
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            success(nil,responseObject);
            self.requestCount --;
            NSLog(@"Reply JSON: %@", responseObject);
        } else {
            failure(nil,error);
            self.requestCount --;
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
}

- (void)DELETE:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    self.requestCount ++;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    if (self.token && [self.token length]) {
        [manager.requestSerializer setValue:self.token forHTTPHeaderField:@"Token"];
    }
    [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
        self.requestCount --;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
        self.requestCount --;
    }];
}


- (void)uploadfile:(NSArray *)dataList block:(void (^)(NSArray *files, NSError *error))dataBlock
{
    if(dataList == nil || dataList.count == 0)
    {
        dataBlock([[NSArray alloc]init],nil);
        return;
    }

    __block NSArray *updataList = [dataList map:^id(UIImage *element) {
        if ([element isKindOfClass:[NSData class]])return element;
        return UIImageJPEGRepresentation(element, 0.8);
    }];
    
    NSString *url = [NSString stringWithFormat:@"%@/homePage/qiniu/token",BN_BASEURL];
    __block NSInteger index = 0;
    __block NSMutableArray *returnArray = [@[] mutableCopy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showWIthLabelAnnularDeterminate];
    });
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSString *token = [[dic objectForKey:@"result"] objectForKey:@"qiniuToken"];
            
            for (NSData *data in updataList)
            {
                QNUploadManager *upManager = [[QNUploadManager alloc] init];
                int x = arc4random() % 10000;
                NSString *key = [NSString stringWithFormat:@"%fU%d",[[NSDate date] timeIntervalSince1970],x];
                key = [key stringByReplacingOccurrencesOfString:@"." withString:@""];
                
                [upManager putData:data key:key token:token
                          complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                              NSLog(@"%@", info);
                              NSLog(@"%@", resp);
                              [returnArray addObject:key];
                              index++;
                          } option:nil];
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                while (index != updataList.count)
                {
                    _upLoadProgress = (index*1.0/updataList.count);
                    usleep(100);
                }
                _upLoadProgress = 2.0;
                dataBlock(returnArray,nil);
            });
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"失败  %@",errorStr);
            dataBlock(nil,[NSError errorWithDomain:errorStr code:codeNumber.integerValue userInfo:@{@"remark":errorStr}]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        dataBlock(nil,error);
    }];
}

    
- (void)showWIthLabelAnnularDeterminate{
    [downloadHUD removeFromSuperview];
    downloadHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:downloadHUD];
    downloadHUD.mode = MBProgressHUDModeAnnularDeterminate;
    downloadHUD.delegate = self;
    downloadHUD.label.text = @"Loading";
    [downloadHUD showAnimated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _upLoadProgress = 0;
        [self refreshProgressTask];
    });
    
}

- (void)refreshProgressTask {
    NSLog(@"已下载 %f",_upLoadProgress);
    downloadHUD.progress = _upLoadProgress*1.0;
    if (_upLoadProgress < 1.1f)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshProgressTask];
        });
    } else {
        [downloadHUD hideAnimated:YES];
    }
}

+(void)showErrorCode:(NSString *)str code:(int)code
{
    
}

@end
