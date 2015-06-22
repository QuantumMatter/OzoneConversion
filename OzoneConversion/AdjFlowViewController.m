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

@end

@implementation AdjFlowViewController
{
    Conversion *conversion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    conversion = [[Conversion alloc] init];
}
- (IBAction)submit:(id)sender {
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
