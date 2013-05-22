//
//  FDDPUserInfoViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/21/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPUserInfoViewController.h"

@interface FDDPUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *UILabelfirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UILabellastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UILabelusernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *UIButtonlogOutButton;

@end

@implementation FDDPUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
