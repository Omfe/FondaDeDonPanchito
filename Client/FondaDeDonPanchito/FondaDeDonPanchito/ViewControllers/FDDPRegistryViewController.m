//
//  FDDPRegistryViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/21/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPRegistryViewController.h"

@interface FDDPRegistryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;
@property (strong, nonatomic) NSArray *ordersArray;

@end

@implementation FDDPRegistryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Registry";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchAllOrders];
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ordersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Action Methods
- (IBAction)addNewOrder:(id)sender
{
    
}


#pragma mark - Private Method
- (void)fetchAllOrders
{
    
}
@end
//* Agregar los siguientes métodos privados:
//* fetchAllOrders, void, no recibe nada
//* Mandar llamar fetchAllOrders en viewDidLoad:
