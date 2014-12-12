//
//  RPLoginModel.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/11/3.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "PPBaseModel.h"

@interface RPLoginModel : PPBaseModel

+ (NSString *)validateMobile:(NSString *)mobile;

+ (NSString *)validatePassword:(NSString *)pwd;

+ (NSString *)validateVCode:(NSString *)vcode;

- (void)doLogin:(id)params complete:(void(^)(id json, NSError *error))complete;

- (void)doRegister:(id)params complete:(void(^)(id json, NSError *error))complete;

- (void)fetchSMSCode:(id)params complete:(void(^)(NSError *error))complete;

- (void)checkVcode:(id)params complete:(void(^)(id json, NSError *error))complete;

- (void)doFindPassword:(id)params complete:(void(^)(NSError *error))complete;

- (void)doResetNewPassword:(id)params complete:(void(^)(NSError *error))complete;

@end
