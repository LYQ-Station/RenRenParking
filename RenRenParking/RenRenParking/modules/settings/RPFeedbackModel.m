//
//  RPFeedbackModel.m
//  RenRenParking
//
//  Created by Vincent on 12/10/14.
//  Copyright (c) 2014 CoderFly. All rights reserved.
//

#import "RPFeedbackModel.h"

@implementation RPFeedbackModel

- (void)doFeedback:(id)params complete:(void(^)(NSError *error))complete
{
    NSMutableURLRequest *re = [PPBaseModel requestWithJsonParam:params];
    re.URL = [NSURL URLWithString:[PPBaseService apiForKey:kApiFeedback]];
    
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
