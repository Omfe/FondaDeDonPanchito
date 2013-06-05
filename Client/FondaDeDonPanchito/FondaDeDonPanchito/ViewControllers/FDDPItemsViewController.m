//
//  FDDPItemsViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPItemsViewController.h"
#import "FDDPWebServicesManager.h"
#import "FDDPItem.h"

@interface FDDPItemsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;
@property (strong, nonatomic) NSArray *itemsArray;

@end

@implementation FDDPItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Items";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self fetchAllItems];
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"ItemsTableViewCellIdentifier";
    FDDPItem *item;
    
    cell = [self.itemsTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    item = [[FDDPItem alloc] init];
    item = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.itemName];
    
    if (!self.completionBlock) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDDPItem *item;
    
    item = [self.itemsArray objectAtIndex:indexPath.row];
    if (self.completionBlock) {
        self.completionBlock(item);
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Action Methods
- (IBAction)addNewItem:(id)sender
{
   // [self presentOrderEditorViewControllerWithOrder:nil];
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
- (void)fetchAllItems
{
    FDDPWebServicesManager *webServicesManager;
    
    webServicesManager = [[FDDPWebServicesManager alloc] init];
    [webServicesManager fetchAllItems:^(NSArray *items, NSError *error) {
        self.itemsArray= items;
        [self.itemsTableView reloadData];
    }];
}

- (void)setupUI
{
    if (self.completionBlock) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelWasPressed:)];
}

- (void)presentItemEditorViewControllerWithOrder:(FDDPItem *)item
{
    
}


@end
