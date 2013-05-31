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
#import "FDDPAdminViewController.h"

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
        self.passwordTextField.text = @"";
    }];
}

- (void)pushToRegistry
{
    UITabBarController *tabBarController;
    FDDPRegistryViewController *registryViewController;
    FDDPUserInfoViewController *userInfoViewController;
    FDDPAdminViewController *adminViewController;
    
    registryViewController = [[FDDPRegistryViewController alloc] initWithNibName:@"FDDPRegistryViewController" bundle:nil];
    userInfoViewController = [[FDDPUserInfoViewController alloc] initWithNibName:@"FDDPUserInfoViewController" bundle:nil];
    adminViewController = [[FDDPAdminViewController alloc] initWithNibName:@"FDDPAdminViewController" bundle:nil];
    
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.navigationItem.hidesBackButton = YES;
    
    if ([self shouldShowAdminScreen]) {
        [tabBarController setViewControllers:@[registryViewController, userInfoViewController, adminViewController] animated:YES];
        [self.navigationController pushViewController:tabBarController animated:YES];
    } else{

    [tabBarController setViewControllers:@[registryViewController, userInfoViewController] animated:YES];
    [self.navigationController pushViewController:tabBarController animated:YES];
    }
}

- (BOOL)shouldShowAdminScreen
{
    FDDPUser *user;;
    user = [[FDDPAuthenticationManager sharedManager] loggedInUser];
    
    if (!user.isAdmin.boolValue) {
        return user.isAdmin.boolValue;
    }
    else {
        return user.isAdmin.boolValue;
    }
}

//* En ese método, regresar YES si el loggedInUser es admin, NO si no

@end
