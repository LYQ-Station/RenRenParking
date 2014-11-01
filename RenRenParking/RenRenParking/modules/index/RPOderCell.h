//
//  RPOderCell.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/25.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPOderCell : UITableViewCell

@property (nonatomic, copy) NSString *labelDateText;
@property (nonatomic, copy) NSString *labelStatusText;
@property (nonatomic, copy) NSString *labelTimeText;
@property (nonatomic, copy) NSString *labelPlaceText;
@property (nonatomic, copy) NSString *labelChargeText;

+ (CGFloat)height;

+ (RPOderCell *)cell;

@end
