//
//  RPIndexViewController.h
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/23.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface RPDragGestureRecognizer : UIGestureRecognizer

@property (nonatomic, assign) CGFloat offsetY;

@end


@interface RPIndexViewController : UIViewController

+ (UINavigationController *)navController;

@end
