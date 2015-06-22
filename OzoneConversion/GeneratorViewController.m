//
//  GeneratorViewController.m
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "GeneratorViewController.h"
#import "Conversion.h"

@interface GeneratorViewController ()
@property (strong, nonatomic) IBOutlet UITextField *inputSLMP;
@property (strong, nonatomic) IBOutlet UITextField *inputDensity;
@property (strong, nonatomic) IBOutlet UILabel *outputResult;

@end

@implementation GeneratorViewController
{
    Conversion *conversion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    conversion = [[Conversion alloc] init];
}
- (IBAction)submit:(id)sender {
    NSString *result = [conversion OutputOzoneGenerator:self.inputSLMP.text density:self.inputDensity.text];
    self.outputResult.text = result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
