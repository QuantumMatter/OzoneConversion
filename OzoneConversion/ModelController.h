//
//  ModelController.h
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

-(void) goToController:(NSUInteger)position;

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;

@property RootViewController *parent;

@end

