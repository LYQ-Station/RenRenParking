//
//  RPFeedbackModel.h
//  RenRenParking
//
//  Created by Vincent on 12/10/14.
//  Copyright (c) 2014 CoderFly. All rights reserved.
//

#import "PPBaseModel.h"

@interface RPFeedbackModel : PPBaseModel

- (void)doFeedback:(id)params complete:(void(^)(NSError *error))complete;

@end
