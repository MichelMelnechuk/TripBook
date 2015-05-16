//
//  FirstLaunchViewController.m
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "FirstLaunchViewController.h"
#import "User.h"
#import "ParseWrapper.h"

@interface FirstLaunchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation FirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveUserData:(id)sender {
    if ([self.loginTextField.text isEqual:@""]) {
        UIAlertView *logAlert = [[UIAlertView alloc]initWithTitle:@"Short login"
                                                          message:@"enter longer login"
                                                         delegate:self
                                                cancelButtonTitle:@"ok"
                                                otherButtonTitles:nil, nil];
        [logAlert show];
        return;
    }
    if ([self.passwordTextField.text isEqual:@""]) {
        UIAlertView *passAlert = [[UIAlertView alloc]initWithTitle:@"password err"
                                                          message:@"enter  correct password"
                                                         delegate:self
                                                cancelButtonTitle:@"ok"
                                                otherButtonTitles:nil, nil];
        [passAlert show];
        return;
    }
    User *newUser = [[User alloc]init];
    newUser.login = self.loginTextField.text;
    newUser.password = self.passwordTextField.text;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"appInitialized"];
    [[ParseWrapper sharedInstance]saveUser:newUser];
    [self performSegueWithIdentifier:@"firstLaunchSeque" sender:self];
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
