//
//  LoginViewController.m
//  TripBook
//
//  Created by Air on 5/15/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "LoginViewController.h"
#import "ParseWrapper.h"
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *setLoginTextField;
@property (weak, nonatomic) IBOutlet UITextField *setPasswordTextField;

@end

@implementation LoginViewController
{
    BOOL isUnlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isUnlock = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didEnterApp:(id)sender {
    User *enterUser = [[ParseWrapper sharedInstance]getUser];
    if (![self.setLoginTextField.text isEqual:enterUser.login]) {
        UIAlertView *setLoginAlert = [[UIAlertView alloc]initWithTitle:@"wrong login"
                                                               message:@"Enter correct login"
                                                              delegate:self cancelButtonTitle:@"ok"
                                                     otherButtonTitles:nil, nil];
        [setLoginAlert show];
        return;
    }else if (![self.setPasswordTextField.text isEqual:enterUser.password]) {
        UIAlertView *setPasswordAlert = [[UIAlertView alloc]initWithTitle:@"wrong password"
                                                               message:@"Enter correct password"
                                                              delegate:self cancelButtonTitle:@"ok"
                                                     otherButtonTitles:nil, nil];
        [setPasswordAlert show];
                return;
    }
    
    if (isUnlock) {
        [self performSegueWithIdentifier:@"unlockSeque" sender:self];
    }
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
