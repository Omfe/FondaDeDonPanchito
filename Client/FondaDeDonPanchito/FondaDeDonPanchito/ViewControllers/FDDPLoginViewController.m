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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if (self.usernameTextField.text.length == 0) {
        [self.usernameTextField becomeFirstResponder];
    } else {
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    [[FDDPAuthenticationManager sharedManager] loginWithUsername:self.usernameTextField.text withPassword:self.passwordTextField.text andCompletion:^(NSString *message, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return;
        }
        [self.view endEditing:YES];
        [self pushToMainNavigation];
        self.passwordTextField.text = @"";
    }];
}

- (void)pushToMainNavigation
{
    UITabBarController *tabBarController;
    
    tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:[self tabBarViewControllers]];
    
    [self.navigationController pushViewController:tabBarController animated:YES];
}

- (NSArray *)tabBarViewControllers
{
    FDDPRegistryViewController *registryViewController;
    FDDPAdminViewController *adminViewController;
    FDDPUserInfoViewController *userInfoViewController;
    UINavigationController *registryNavigationViewController;
    UINavigationController *adminNavigationViewController;
    UINavigationController *userInfoNavigationViewController;
    NSArray *viewControllers;
    
    registryViewController = [[FDDPRegistryViewController alloc] initWithNibName:@"FDDPRegistryViewController" bundle:nil];
    adminViewController = [[FDDPAdminViewController alloc] initWithNibName:@"FDDPAdminViewController" bundle:nil];
    userInfoViewController = [[FDDPUserInfoViewController alloc] initWithNibName:@"FDDPUserInfoViewController" bundle:nil];
    
    registryNavigationViewController = [[UINavigationController alloc] initWithRootViewController:registryViewController];
    adminNavigationViewController = [[UINavigationController alloc] initWithRootViewController:adminViewController];
    userInfoNavigationViewController = [[UINavigationController alloc] initWithRootViewController:userInfoViewController];
    
    if ([self shouldShowAdminScreen]) {
        viewControllers = @[ registryNavigationViewController, adminNavigationViewController, userInfoNavigationViewController ];
    } else {
        viewControllers = @[ registryNavigationViewController, userInfoNavigationViewController ];
    }
    
    return viewControllers;
}

- (BOOL)shouldShowAdminScreen
{
    return [[FDDPAuthenticationManager sharedManager] loggedInUser].isAdmin.boolValue;
}

@end