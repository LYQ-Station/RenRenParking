//
//  PPBaseService.m
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseService.h"

@implementation PPBaseService

+ (NSString *)apiForKey:(const NSString *)key
{
    static NSDictionary *apis = nil;
    
    if (!apis)
    {
        apis = @{
                 kApiGetSMSCode:@"AppComm/get_code",
                 kApiCheckSMSCode:@"AppComm/check_code",
                 kApiLogin:@"AppUser/login",
                 kApiRegister:@"AppUser/regist",
                 kApiResetPwd:@"AppUser/resetpwd",
                 kApiUpdateUserProfile:@"AppUser/change_user_info",
                 kApiFeedback:@"AppService/advice",
                 kApiServicePlaceAround:@"AppService/field_list",
                 kApiServicePlaceNearnest:@"",
                 kApiSubmitOrder:@"AppService/park_car"
                 };
    }
    
    return [NSString stringWithFormat:@"%@/Home/%@", PP_API_URL, [apis objectForKey:key]];
}

@end
