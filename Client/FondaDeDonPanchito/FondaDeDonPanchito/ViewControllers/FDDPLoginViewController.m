//
//  FDDPLoginViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPLoginViewController.h"
#import "FDDPAuthenticationController.h"

@interface FDDPLoginViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@end

@implementation FDDPLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == self.usernameTextField ) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self _login];
    }
    
    return YES;
}


#pragma mark - Action Methods
- (IBAction)loginButtonWasPressed:(id)sender
{
    [self _login];
}


#pragma mark - Private Methods
- (void)_login
{
    [self.view endEditing:YES];
    [[FDDPAuthenticationController sharedAuthenticationController] loginWithUsername:self.usernameTextField.text withPassword:self.passwordTextField.text andCompletion:^(NSString *message, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
    }];
}

@end
