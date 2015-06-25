//
//  AdjFlowViewController.m
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "AdjFlowViewController.h"
#import "Conversion.h"

@interface AdjFlowViewController ()
@property (strong, nonatomic) IBOutlet UITextField *inputPSI;
@property (strong, nonatomic) IBOutlet UITextField *inputFlow;
@property (strong, nonatomic) IBOutlet UILabel *outputResult;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation AdjFlowViewController
{
    Conversion *conversion;
    bool menu;
    NSMutableArray *menuArray;
}

- (IBAction)menuPressed:(id)sender {
    if (!menu) {
        [self loadMenu];
    } else {
        [self hideMenu];
    }
    menu = !menu;
}

-(void) loadMenu {
    for (int i = 0; i < [menuArray count]; i++) {
        UIView *view = [menuArray objectAtIndex:i];
        view.hidden = false;
    }
}

-(void) hideMenu {
    for (int i = 0; i < [menuArray count]; i++) {
        UIView *view = [menuArray objectAtIndex:i];
        view.hidden = true;
    }
}

-(void) loadMenuComponents {
    menu = false;
    if (menuArray == nil) {
        menuArray = [[NSMutableArray alloc] init];
    }
    CGRect origin = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 60, 60);
    NSArray *test = [[NSBundle mainBundle] loadNibNamed:@"Menu" owner:self options:nil];
    for (int i = 0; i < [test count]; i++) {
        UIView *view = [test objectAtIndex:i];
        CGRect frame;
        switch (i) {
            case 0:             // X   Y
                frame = CGRectMake(origin.origin.x - 50 - 30, origin.origin.y - 86 - 30, 60, 60);
                break;
                
            case 1:
                frame = CGRectMake(origin.origin.x + 50 - 30, origin.origin.y - 86 - 30, 60, 60);
                break;
                
            case 2:             // X   Y
                frame = CGRectMake(origin.origin.x + 100 - 30, origin.origin.y - 0  - 30, 60, 60);
                break;
                
            case 3:
                frame = CGRectMake(origin.origin.x + 50 - 30, origin.origin.y + 86 - 30, 60, 60);
                break;
                
            case 4:             // X   Y
                frame = CGRectMake(origin.origin.x - 50 - 30, origin.origin.y + 86 - 30, 60, 60);
                break;
                
            case 5:
                frame = CGRectMake(origin.origin.x - 100 - 30, origin.origin.y - 0 - 30, 60, 60);
                break;
                
            case 6:
                frame = CGRectMake(origin.origin.x - 30, origin.origin.y - 30, 60, 60);
                break;
                
            default:
                frame = CGRectMake(0, 0, 0, 0);
                break;
        }
        [view setFrame:frame];
        view.hidden = true;
        [self.view addSubview:view];
        [menuArray addObject:view];
        [self makeButton:frame selector:i];
    }
}

-(void) makeButton:(CGRect)frame selector:(NSUInteger)target {
    UIButton *button01 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    switch (target) {
        case 0:
            [button01 addTarget:self
                         action:@selector(wButton)
               forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 1:
            [button01 addTarget:self
                         action:@selector(fButton)
               forControlEvents:UIControlEventTouchUpInside];
            
        case 2:
            [button01 addTarget:self
                         action:@selector(dButton)
               forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 3:
            [button01 addTarget:self
                         action:@selector(gButton)
               forControlEvents:UIControlEventTouchUpInside];
            
        case 4:
            [button01 addTarget:self
                         action:@selector(pButton)
               forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 5:
            [button01 addTarget:self
                         action:@selector(aButton)
               forControlEvents:UIControlEventTouchUpInside];
            
        default:
            break;
    }
    [button01 setTitle:@"  " forState:UIControlStateNormal];
    
    button01.frame = frame;
    [self.view addSubview:button01];
    button01.layer.zPosition = 1000;
    button01.hidden = YES;
    //button01.alpha = 0;
    [menuArray addObject:button01];
}

-(void) wButton {
    [self goTo:0 from:5];
}

-(void) fButton {
    [self goTo:1 from:5];
}

-(void) dButton {
    [self goTo:2 from:5];
}

-(void) gButton {
    [self goTo:3 from:5];
}

-(void) pButton {
    [self goTo:4 from:5];
}

-(void) aButton {
    [self goTo:5 from:5];
}


-(void) goTo:(NSUInteger)destination from:(NSUInteger)from {
    [self hideMenu];
    NSArray *_vcIDs = @[//@"DataViewController",
                        @"FlowRateViewController",
                        @"FeedGasViewController",
                        @"DryViewController",
                        @"GeneratorViewController",
                        @"PPMViewController",
                        @"AdjFlowViewController"];
    
    if (destination == from) {
        return;
    }
    if (destination > from) {
        for (nil; from < destination; from++) {
            UIPageViewController *view = (UIPageViewController *) self.parentViewController;
            
            UIViewController *currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:[_vcIDs objectAtIndex:from + 1]];
            NSArray *viewControllers = @[currentViewController];
            [view setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
    } else {
        for (nil; from > destination; from--) {
            UIPageViewController *view = (UIPageViewController *) self.parentViewController;
            
            UIViewController *currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:[_vcIDs objectAtIndex:from - 1]];
            NSArray *viewControllers = @[currentViewController];
            [view setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMenuComponents];
    //self.menuButton.hidden = true;
    conversion = [[Conversion alloc] init];
    self.menuButton.alpha = 0.1;
}
- (IBAction)submit:(id)sender {
    [self.view endEditing:YES];
    NSString *result = [conversion AdjustedFlow:self.inputPSI.text Measured:self.inputFlow.text];
    self.outputResult.text = result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
