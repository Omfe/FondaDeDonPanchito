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

@interface FDDPUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *UIButtonlogOutButton;


@end

@implementation FDDPUserInfoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    FDDPUser *user;
    
    user = [[FDDPAuthenticationManager sharedManager] loggedInUser];
    self.firstNameLabel.text = user.firstName;
    self.lastNameLabel.text = user.lastname;
    self.usernameLabel.text = user.username;
    
    NSLog(@"%@", user.firstName);
}

@end
