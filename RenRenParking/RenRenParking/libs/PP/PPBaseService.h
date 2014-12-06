//
//  PPBaseService.h
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - * login/register

static const NSString *kApiInitDevice = @"InitDevice";
static const NSString *kApiUploadUserInfo = @"uploadUserInfo";
static const NSString *kApiQueryPoint = @"queryPoint";
static const NSString *kApiSuggest = @"suggest";
static const NSString *kApiParkingDetails = @"parkingDetail";
static const NSString *kApiSearch = @"search";

static const NSString *kApiGetSMSCode = @"GetSMSCode";
static const NSString *kApiCheckSMSCode = @"CheckSMSCode";

static const NSString *kApiLogin = @"login";
static const NSString *kApiRegister = @"register";
static const NSString *kApiResetPwd = @"reset-pwd";

static const NSString *kApiUpdateUserProfile = @"update-user-profile";

#pragma mark - * user profiles

#pragma mark - * map service

@interface PPBaseService : NSObject

+ (NSString *)apiForKey:(const NSString *)key;

@end
