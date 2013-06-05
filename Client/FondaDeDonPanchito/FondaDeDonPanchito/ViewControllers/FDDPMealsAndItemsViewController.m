//
//  FDDPMealsAndItemsViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 6/3/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPMealsAndItemsViewController.h"
#import "FDDPOrder.h"
#import "FDDPMeal.h"
#import "FDDPItem.h"

@interface FDDPMealsAndItemsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *orderObjectsArray;
@property (nonatomic, weak) IBOutlet UITableView *orderObjectsTableView;

@end

@implementation FDDPMealsAndItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Remove";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self setupDataSource];
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderObjectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"MealsAndItemsTableViewCellIdentifier";
    id object;
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    object = [self.orderObjectsArray objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[FDDPMeal class]]) {
        cell.textLabel.text = [(FDDPMeal *)object mealName];
    } else if ([object isKindOfClass:[FDDPItem class]]) {
        cell.textLabel.text = [(FDDPItem *)object itemName];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *meals;
    NSMutableArray *items;
    id object;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    object = [self.orderObjectsArray objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[FDDPMeal class]]) {
        meals = [self.order.meals mutableCopy];
        [meals removeObject:object];
        self.order.meals = meals;
    } else if ([object isKindOfClass:[FDDPItem class]]) {
        items = [self.order.items mutableCopy];
        [items removeObject:object];
        self.order.items = items;
    }
    
    [self setupDataSource];
    [tableView reloadData];
}


#pragma mark - Action Methods
- (IBAction)doneWasPressed:(id)sender
{
    if (self.completionBlock) {
        self.completionBlock();
    }
}


#pragma mark - Private Methods
- (void)setupUI
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWasPressed:)];
}

- (void)setupDataSource
{
    self.orderObjectsArray = [NSMutableArray array];
    [self.orderObjectsArray addObjectsFromArray:self.order.meals];
    [self.orderObjectsArray addObjectsFromArray:self.order.items];
    [self.orderObjectsTableView reloadData];
}

@end
