//
//  demoViewModel.m
//  BN_BaseKit
//
//  Created by newman on 16/11/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "demoViewModel.h"
#import "BC_ToolRequest.h"
#import "MJExtension.h"
#import "NSArray+TPCategory.h"

@implementation Advertisement

@end

@implementation demoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.advertisementArray = [[NSMutableArray alloc]initFromNet];
    }
    return self;
}

- (void)getAdvertisementListArrayClearData:(BOOL)clear
{
    int curPage = round(self.advertisementArray.count/10.0);

    NSString *url = [NSString stringWithFormat:@"http://112.74.31.159:26088/lbb-app/homePage/advertisementList"];
    __weak typeof(self) temp = self;
    self.advertisementArray.loadSupport.loadEvent = NetLoadingEvent;
    
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSLog(@"dsdsd  %@",dic);
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"成功  %@",[dic objectForKey:@"rows"]);
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [Advertisement objectArrayWithKeyValuesArray:array];
            
            if (clear == YES)
            {
                [temp.advertisementArray removeAllObjects];
            }
            
            [temp.advertisementArray addObjectsFromArray:returnArray];
            temp.advertisementArray.networkTotal = [NSNumber numberWithInt:50];
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            //            [ToolRequest showErrorCode:errorStr code:codeNumber.intValue];
        }
        
        temp.advertisementArray.loadSupport.loadEvent = codeNumber.intValue;
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        temp.advertisementArray.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
    
}

@end
