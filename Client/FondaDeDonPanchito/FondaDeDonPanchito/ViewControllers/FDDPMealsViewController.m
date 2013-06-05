//
//  FDDPMealsViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 6/3/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPMealsViewController.h"

@interface FDDPMealsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mealsTableView;

@end

@implementation FDDPMealsViewController

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
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end
