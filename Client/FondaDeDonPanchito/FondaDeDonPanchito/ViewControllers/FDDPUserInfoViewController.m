//
//  FDDPUserInfoViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/21/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPUserInfoViewController.h"
#import "FDDPAuthenticationManager.h"
#import "FDDPUser.h"
#import "FDDPLoginViewController.h"

@interface FDDPUserInfoViewController () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *UIButtonlogOutButton;

@property (strong, nonatomic) UIActionSheet *logoutActionSheet;

@end

@implementation FDDPUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"User Info";
    }
    return self;
}

- (void)viewDidLoad
{
    FDDPUser *user;
    [super viewDidLoad];
    
    user = [[FDDPAuthenticationManager sharedManager] loggedInUser];
    self.firstNameLabel.text = user.firstName;
    self.lastNameLabel.text = user.lastname;
    self.usernameLabel.text = user.username;
}

- (IBAction)logoutButtonWasPressed:(id)sender {
    
    
    self.logoutActionSheet = [[UIActionSheet alloc] initWithTitle:@"Logout?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Logout" otherButtonTitles:nil, nil];
    [self.logoutActionSheet showFromTabBar:self.tabBarController.tabBar];
    self.logoutActionSheet.delegate = self;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FDDPUser *user;
    FDDPLoginViewController *loginViewController;
    loginViewController = [[FDDPLoginViewController alloc] initWithNibName:@"FDDPLoginViewController" bundle:nil];
    user = [[FDDPAuthenticationManager sharedManager] loggedInUser];
    
    if (buttonIndex == 0){
        [self.view endEditing:YES];
        [[FDDPAuthenticationManager sharedManager] logoutWithToken:user.token andCompletion:^(NSString *message, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
        }];
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }
}


@end
