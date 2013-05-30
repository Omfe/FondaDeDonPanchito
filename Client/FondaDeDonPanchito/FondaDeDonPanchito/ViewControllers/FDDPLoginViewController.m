//
//  FDDPLoginViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPLoginViewController.h"
#import "FDDPAuthenticationManager.h"
#import "FDDPRegistryViewController.h"
#import "FDDPUserInfoViewController.h"

@interface FDDPLoginViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@end

@implementation FDDPLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login";
    [self.usernameTextField becomeFirstResponder];
}


#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == self.usernameTextField ) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self login];
    }
    
    return YES;
}


#pragma mark - Action Methods
- (IBAction)loginButtonWasPressed:(id)sender
{
    [self login];
    self.passwordTextField.text = @"";
}


#pragma mark - Private Methods
- (void)login
{
    [self.view endEditing:YES];
    [[FDDPAuthenticationManager sharedManager] loginWithUsername:self.usernameTextField.text withPassword:self.passwordTextField.text andCompletion:^(NSString *message, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return;
        }
        [self pushToRegistry];
    }];
}

- (void)pushToRegistry
{
    UITabBarController *tabBarController;
    FDDPRegistryViewController *registryViewController;
    FDDPUserInfoViewController *userInfoViewController;
    
    registryViewController = [[FDDPRegistryViewController alloc] initWithNibName:@"FDDPRegistryViewController" bundle:nil];
    userInfoViewController = [[FDDPUserInfoViewController alloc] initWithNibName:@"FDDPUserInfoViewController" bundle:nil];
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.navigationItem.hidesBackButton = YES;
    [tabBarController setViewControllers:@[registryViewController, userInfoViewController] animated:YES];
    [self.navigationController pushViewController:tabBarController animated:YES];
}

@end
