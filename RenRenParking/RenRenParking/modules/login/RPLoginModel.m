//
//  RPLoginModel.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/11/3.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPLoginModel.h"

@implementation RPLoginModel

- (void)doLogin:(id)params complete:(void(^)(id json, NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiLogin]];
    
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

- (void)doRegister:(id)params complete:(void(^)(id json, NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiRegister]];
    
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

- (void)fetchSMSCode:(id)params complete:(void(^)(id json, NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiGetSMSCode]];
    
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

- (void)checkVcode:(id)params complete:(void(^)(id json, NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiGetSMSCode]];
    
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

- (void)doFindPassword:(id)params complete:(void(^)(NSError *error))complete
{
    
}

- (void)doResetNewPassword:(id)params complete:(void(^)(NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiUpdateUserProfile]];
    
    self.opeartion = [[AFHTTPRequestOperation alloc]initWithRequest:re];
    
    [self.opeartion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = nil;
        [PPBaseModel parseResponseData:responseObject error:&err];
        if (complete) complete(err);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(error);
    }];
    
    [self.opeartion start];
}

@end
