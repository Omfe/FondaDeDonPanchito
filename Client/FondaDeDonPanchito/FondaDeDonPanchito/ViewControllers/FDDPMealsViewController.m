//
//  FDDPMealsViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 6/3/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPMealsViewController.h"
#import "FDDPWebServicesManager.h"
#import "FDDPMeal.h"

@interface FDDPMealsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mealsTableView;
@property (strong, nonatomic) NSArray *mealsArray;

@end

@implementation FDDPMealsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Meals";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self fetchAllMeals];
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mealsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"MealsTableViewCellIdentifier";
    FDDPMeal *meal;
    
    cell = [self.mealsTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    meal = [[FDDPMeal alloc] init];
    meal = [self.mealsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", meal.mealName];
    
    if (!self.completionBlock) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDDPMeal *meal;
    
    meal = [self.mealsArray objectAtIndex:indexPath.row];
    if (self.completionBlock) {
        self.completionBlock(meal);
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Action Methods
- (IBAction)addNewMeal:(id)sender
{
    //[self presentOrderEditorViewControllerWithOrder:nil];
}

- (IBAction)cancelWasPressed:(id)sender
{
    if (self.completionBlock) {
        self.completionBlock(nil);
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Method
- (void)fetchAllMeals
{
    FDDPWebServicesManager *webServicesManager;
    
    webServicesManager = [[FDDPWebServicesManager alloc] init];
    [webServicesManager fetchAllMeals:^(NSArray *meals, NSError *error) {
        self.mealsArray = meals;
        [self.mealsTableView reloadData];
    }];
}

- (void)setupUI
{
    if (self.completionBlock) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewMeals:)];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelWasPressed:)];
}


- (void)presentMealEditorViewControllerWithOrder:(FDDPMeal *)meal
{
    
}

@end
