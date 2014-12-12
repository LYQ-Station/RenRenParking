//
//  RPLoginModel.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/11/3.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPLoginModel.h"

@implementation RPLoginModel

+ (NSString *)validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (![phoneTest evaluateWithObject:mobile])
    {
        return NSLocalizedString(@"手机号码错误", nil);
    }
    
    return nil;
}

+ (NSString *)validatePassword:(NSString *)pwd
{
    if (pwd.length < 6 || pwd.length > 12)
    {
        return NSLocalizedString(@"请确认6~12位密码", nil);
    }
    
    return nil;
}

+ (NSString *)validateVCode:(NSString *)vcode
{
    if (!vcode.length)
    {
        return NSLocalizedString(@"请填写验证码", nil);
    }
    
    return nil;
}

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

- (void)fetchSMSCode:(id)params complete:(void(^)(NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiGetSMSCode]];
    
    self.opeartion = [[AFHTTPRequestOperation alloc]initWithRequest:re];
    
    [self.opeartion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = nil;
        id json = [PPBaseModel parseResponseData:responseObject error:&err];
        NSLog(@"%@", json);
        if (complete) complete(err);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(error);
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
