//
//  RPMapModel.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/12/11.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPMapModel.h"

@implementation RPMapModel

- (void)doFetchServicePlaceAround:(id)params complete:(void(^)(id json, NSError *error))complete
{
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr addObject:@{@"id":@"1",
                     @"wait_time":@"10",
                     @"charge":@"15",
                     @"coordinates":@[[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.590291,113.871609)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.586019,113.876819)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.58335,113.873909)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.585085,113.869669)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.584618,113.866686)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.586453,113.864207)]
                                      ]
                     }];
    
    [arr addObject:@{@"id":@"2",
                     @"wait_time":@"16",
                     @"charge":@"13",
                     @"coordinates":@[[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.582516,113.86065)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.578711,113.865249)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.575608,113.861907)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.579145,113.85756)]
                                      ]
                     }];
    
    [arr addObject:@{@"id":@"3",
                     @"wait_time":@"20",
                     @"charge":@"18",
                     @"coordinates":@[[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.583483,113.871609)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.579379,113.879838)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.576142,113.876927)],
                                      [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(22.580146,113.871753)]
                                      ]
                     }];
    
    if (complete)
    {
        complete(arr, nil);
    }
}

- (void)doFetchServicePlaceNearnest:(id)params complete:(void(^)(id json, NSError *error))complete
{
    
}

- (void)doMakeOrder:(id)params complete:(void(^)(id json, NSError *error))complete
{
    //需要返回订单号、司机信息
}

@end
