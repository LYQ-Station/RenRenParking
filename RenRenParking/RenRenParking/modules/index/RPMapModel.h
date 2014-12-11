//
//  RPMapModel.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/12/11.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "PPBaseModel.h"

@interface RPMapModel : PPBaseModel

- (void)doFetchServicePlaceAround:(id)params complete:(void(^)(id json, NSError *error))complete;

- (void)doFetchServicePlaceNearnest:(id)params complete:(void(^)(id json, NSError *error))complete;

- (void)doMakeOrder:(id)params complete:(void(^)(id json, NSError *error))complete;

@end
