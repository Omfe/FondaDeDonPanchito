//
//  FDDPAdminViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/29/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//


#import "FDDPAdminViewController.h"
#import "FDDPMealsViewController.h"
#import "FDDPItemsViewController.h"

@interface FDDPAdminViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mealsButton;
@property (weak, nonatomic) IBOutlet UIButton *itemsButton;
@property (weak, nonatomic) IBOutlet UIButton *usersButton;

@end

@implementation FDDPAdminViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Admin";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)mealsButtonWasPressed:(id)sender
{
    FDDPMealsViewController *mealsViewController;
    UINavigationController *mealsNavigationController;
    mealsViewController = [[FDDPMealsViewController alloc] initWithNibName:@"FDDPMealsViewController" bundle:nil];
    mealsNavigationController = [[UINavigationController alloc] initWithRootViewController:mealsViewController];
    [self.navigationController pushViewController:mealsViewController animated:YES];
}

- (IBAction)itemsButtonWasPressed:(id)sender
{
    FDDPItemsViewController *itemsViewController;
    UINavigationController *itemsNavigationController;
    itemsViewController = [[FDDPItemsViewController alloc] initWithNibName:@"FDDPItemsViewController" bundle:nil];
    itemsNavigationController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    [self.navigationController pushViewController:itemsViewController animated:YES];
}

- (IBAction)usersButtonWasPressed:(id)sender
{
    
}
@end
