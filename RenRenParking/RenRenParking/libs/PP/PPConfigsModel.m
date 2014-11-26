//
//  PPConfigsModel.m
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPConfigsModel.h"

@implementation PPConfigsModel

- (void)fetchConfigs:(void(^)(id json, NSError *))complete
{
    NSDictionary *p = @{
                        @"imei":@"1234567",
                        @"brand":@"apple",
                        @"phoneType":@"ios",
                        @"appVer":@"1.0",
                        @"sdkVer":@"1.0"
                        };
    
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:p];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiInitDevice]];
    
    self.opeartion = [[AFHTTPRequestOperation alloc]initWithRequest:re];
    
    [self.opeartion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = nil;
        id json = [PPBaseModel parseResponseData:responseObject error:&err];
        if (complete) complete(json, err);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(nil, error);
    }];
    
    [self.opeartion start];
}

@end
