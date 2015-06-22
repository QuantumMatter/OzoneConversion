//
//  ModelController.m
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "ModelController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *vcIDs;
@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        _vcIDs = @[//@"DataViewController",
                   @"FlowRateViewController",
                   @"FeedGasViewController",
                   @"DryViewController",
                   @"GeneratorViewController",
                   @"PPMViewController",
                   @"AdjFlowViewController"];
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([self.vcIDs count] == 0) || (index >= [self.vcIDs count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    //UIViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    //dataViewController.dataObject = self.vcIDs[index];
    //return dataViewController;
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:[self.vcIDs objectAtIndex:index]];
    return viewController;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    //[self.vcIDs indexOfObject:viewController.dataObject];
    NSString *name = NSStringFromClass([viewController class]);
    NSUInteger result = [self.vcIDs indexOfObject:name];
    if (result == NSNotFound) {
        NSLog([NSString stringWithFormat:@"Error In Index; Name = %@", name]);
    }
    return result;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.vcIDs count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
