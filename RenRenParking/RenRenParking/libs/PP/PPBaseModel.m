//
//  PPBaseModel.m
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@implementation PPBaseModel

+ (id)model
{
    return [[[self class] alloc] init];
}

+ (NSMutableURLRequest *)requestWithJsonParam:(NSDictionary *)jsonDict
{
    NSError *parseError;
    NSData* jsonData = nil;
    
    if (jsonDict)
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&parseError];
    }
    
    NSMutableURLRequest *re = [[NSMutableURLRequest alloc] init];
    if (jsonData)
    {
        [re setHTTPBody:jsonData];
    }
    
    UIDevice *iDevice = [UIDevice currentDevice];
    
    [re setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [re setValue:iDevice.localizedModel forHTTPHeaderField:@"User-Agent"];
    [re setHTTPMethod:@"POST"];
    
    return re;
}

+ (id)parseResponseData:(NSData *)data error:(NSError *__autoreleasing *)error
{
    if (!data)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1002
                                 userInfo:@{NSLocalizedDescriptionKey:@"无效的data"}];
        
        return nil;
    }
    
    NSData *d = nil;
    
#ifdef PP_ENCRYPT
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    d = [str base64DecodedData];
    d = [d DESDecryptWithKey:PP_SECRET_KEY];
    
    if (!d)
    {
        d = data;
    }
#else
    d = data;
#endif
    
    *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:d
                                                         options:NSJSONReadingMutableContainers
                                                           error:error];
    
    if (*error)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1002
                                 userInfo:@{NSLocalizedDescriptionKey:@"无效的json data"}];
        
        return nil;
    }
    
    if (!json)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1001
                                 userInfo:@{NSLocalizedDescriptionKey:@"服务器返回错误"}];
        
        return nil;
    }
    
    int code = [json[@"retcode"] intValue];
    if (code)
    {
        id msg = nil;
        
        if ([json objectForKey:@"retmsg"])
        {
            msg = json[@"retmsg"];
        }
        
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:code
                                 userInfo:@{NSLocalizedDescriptionKey:msg}];
        
        return nil;
    }
    
    id result = json[@"data"];
    if ([result isEqual:@""])
    {
        return nil;
    }
    
    return result;
}

- (void)cancel
{
    [self.opeartion cancel];
}

- (id)parseResponseData:(NSData *)data error:(NSError *__autoreleasing *)error
{
    return [PPBaseModel parseResponseData:data error:error];
}

@end
