//
//  PPBaseModel.h
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBaseModel : NSObject

@property (nonatomic, strong) AFHTTPRequestOperation *opeartion;

+ (id)model;

+ (NSMutableURLRequest *)requestWithJsonParam:(NSDictionary *)jsonDict;

+ (id)parseResponseData:(NSData *)data error:(NSError *__autoreleasing *)error;

- (void)cancel;

- (id)parseResponseData:(NSData *)data error:(NSError **)error;

@end
