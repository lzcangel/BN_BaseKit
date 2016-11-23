//
//  BC_ToolRequest.m
//  BN_BaseKit
//
//  Created by newman on 16/10/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BC_ToolRequest.h"
#import "QJTL_Global.h"

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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
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
    NSData *sendData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
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


- (void)uploadfile:(NSArray *)dataList fileName:(NSArray *)nameList block:(void (^)(NSArray *files, NSError *error))dataBlock
{
    if(dataList == nil || dataList.count == 0)
    {
        dataBlock([[NSArray alloc]init],nil);
        return;
    }
    _upLoadProgress = 0.f;
    
    NSDictionary *paraDic = @{
                              };
    AFHTTPSessionManager *operationManager = [AFHTTPSessionManager manager];
    operationManager.requestSerializer.timeoutInterval = 20;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showWIthLabelAnnularDeterminate];
    });
    __weak NSArray *block_dataList = dataList;
    __weak NSArray *block_nameList = nameList;
    [operationManager POST:[NSString stringWithFormat:@"%@/upload/save",@""] parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;
        
        for(int i = 0;i<block_dataList.count;i++)
        {
            NSData *data = block_dataList[i];
            NSString *name = block_nameList == nil ? @"photo.jpg":block_nameList[i];
            [formData appendPartWithFileData:data name:name fileName:name mimeType:@"binary/octet-stream"];
        }
        
        NSLog(@"error:%@",error);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        _upLoadProgress = uploadProgress.fractionCompleted;
        ;
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        _upLoadProgress = 2.0;
        NSDictionary *dic = responseObject;
        NSLog(@"<<<%@>>>",dic);
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSDictionary *dataDic = [dic objectForKey:@"result"];
            NSString *str = [dataDic objectForKey:@"files"];
            NSArray *arr = [str componentsSeparatedByString:NSLocalizedString(@";", nil)];
            dataBlock(arr,nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            [BC_ToolRequest showErrorCode:errorStr code:codeNumber.intValue];
        }
        NSLog(@"success:%@",dic);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"上传失败%@",error.localizedDescription);
        NSLog(@"%@",error);
        [BC_ToolRequest showErrorCode:[NSString stringWithFormat:@"%@",error.localizedDescription] code:(int)error.code];
        _upLoadProgress = 2.0;
    }];
}

    
- (void)showWIthLabelAnnularDeterminate{
    [downloadHUD removeFromSuperview];
    downloadHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:downloadHUD];
    downloadHUD.mode = MBProgressHUDModeAnnularDeterminate;
    downloadHUD.delegate = self;
    downloadHUD.label.text = @"Loading";
    
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
//        [downloadHUD hideAnimated:YES];
    }
}

+(void)showErrorCode:(NSString *)str code:(int)code
{
    
}

@end
