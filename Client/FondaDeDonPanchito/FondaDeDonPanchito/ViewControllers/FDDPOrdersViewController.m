//
//  FDDPRegistryViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/21/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrdersViewController.h"
#import "FDDPWebServicesManager.h"
#import "FDDPOrderEditorViewController.h"
#import "FDDPOrder.h"

@interface FDDPOrdersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;
@property (strong, nonatomic) NSArray *ordersArray;

@end

@implementation FDDPOrdersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Orders";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self fetchAllOrders];
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ordersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"OrdersTableViewCellIdentifier";
    FDDPOrder *order;
    
    cell = [self.ordersTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    order = [[FDDPOrder alloc] init];
    order = [self.ordersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = order.orderName;
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Action Methods
- (IBAction)addNewOrder:(id)sender
{
    FDDPOrderEditorViewController *orderEditorViewController;
    
    orderEditorViewController = [[FDDPOrderEditorViewController alloc] initWithNibName:@"FDDPOrderEditorViewController" bundle:nil];
    [self.navigationController pushViewController:orderEditorViewController animated:YES];
}


#pragma mark - Private Method
- (void)fetchAllOrders
{
    FDDPWebServicesManager *webServicesManager;
    
    webServicesManager = [[FDDPWebServicesManager alloc] init];
    [webServicesManager fetchAllOrders:^(NSArray *orders, NSError *error) {
        self.ordersArray = orders;
        [self.ordersTableView reloadData];
        
    }];
}

- (void)setupUI
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewOrder:)];
}

@end