//
//  RootViewController.h
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
-(void) setPosition:(NSUInteger *)index;

@end

