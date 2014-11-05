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

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) CGFloat offsetY;

@end

@protocol RPDragGestureRecognizerDelegate <NSObject>

@optional
- (void) dragGestureGRecognizerBegan:(RPDragGestureRecognizer *)gesture;
- (void) dragGestureGRecognizerMoved:(RPDragGestureRecognizer *)gesture;
- (void) dragGestureGRecognizerEnded:(RPDragGestureRecognizer *)gesture;

@end


@interface RPIndexViewController : UIViewController

+ (UINavigationController *)navController;

@end
