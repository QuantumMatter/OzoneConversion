//
//  PPMViewController.m
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "PPMViewController.h"
#import "Conversion.h"

@interface PPMViewController ()
@property (strong, nonatomic) IBOutlet UITextField *inputCFM;
@property (strong, nonatomic) IBOutlet UITextField *inputPPM;
@property (strong, nonatomic) IBOutlet UILabel *outputResult;

@end

@implementation PPMViewController
{
    Conversion *conversion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    conversion = [[Conversion alloc] init];
}
- (IBAction)submit:(id)sender {
    NSString *result = [conversion OutputOzoneGeneratorPPM:self.inputCFM.text PPM:self.inputPPM.text];
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
