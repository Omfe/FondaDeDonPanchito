//
//  FDDPOrderEditorViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrderEditorViewController.h"
#import "FDDPOrder.h"
#import "FDDPWebServicesManager.h"
#import "FDDPMealsViewController.h"
#import "FDDPItemsViewController.h"
#import "FDDPMealsAndItemsViewController.h"


@interface FDDPOrderEditorViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UITextView *orderNotesTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, weak) IBOutlet UITextView *mealsAndItemsTextView;

@property (strong, nonatomic) UIActionSheet *deleteActionSheet;
@property (nonatomic, assign) BOOL isNewOrder;

@end

@implementation FDDPOrderEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Order Editor";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isNewOrder = NO;
    if (!self.order) {
        self.isNewOrder = YES;
        self.order = [[FDDPOrder alloc] init];
    }
    
    [self setupUI];
}


#pragma mark - UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FDDPWebServicesManager *webServicesManager;
    
    if (buttonIndex == 1) {
        return;
    }
    
    if (!self.isNewOrder) {
        webServicesManager = [[FDDPWebServicesManager alloc] init];
        [webServicesManager deleteOrder:self.order withCompletion:^(NSString *message, NSError *error) {
            [self callCompletionBlock];
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    }
}


#pragma mark - Action Methods
- (IBAction)doneWasPressed:(id)sender
{
    FDDPWebServicesManager *webServicesManager;
    
    webServicesManager = [[FDDPWebServicesManager alloc] init];
    
    self.order.orderNotes = self.orderNotesTextView.text;
    
    if (self.isNewOrder) {
        self.order.orderedAt = [NSDate date];
        [webServicesManager createOrder:self.order withCompletion:^(NSString *message, NSError *error) {
            [self callCompletionBlock];
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    } else {
        [webServicesManager updateOrder:self.order withCompletion:^(NSString *message, NSError *error) {
            [self callCompletionBlock];
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    }
}

- (IBAction)cancelWasPressed:(id)sender
{
    [self callCompletionBlock];
}

- (IBAction)deleteWasPressed:(id)sender
{
    self.deleteActionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil, nil];
    [self.deleteActionSheet showFromTabBar:self.tabBarController.tabBar];
    self.deleteActionSheet.delegate = self;
}

- (IBAction)finishEditing:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)addMealWasPressed:(id)sender
{
    UINavigationController *navigationController;
    FDDPMealsViewController *mealsViewController;
    
    mealsViewController = [[FDDPMealsViewController alloc] initWithNibName:@"FDDPMealsViewController" bundle:nil];
    [mealsViewController setCompletionBlock:^(FDDPMeal *meal){
        NSMutableArray *meals;
        
        meals = [self.order.meals mutableCopy];
        [meals addObject:meal];
        self.order.meals = meals;
        [self updateMealsAndItemsTextView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:mealsViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)addItemWasPressed:(id)sender
{
    UINavigationController *navigationController;
    FDDPItemsViewController *itemsViewController;
    
    itemsViewController = [[FDDPItemsViewController alloc] initWithNibName:@"FDDPItemsViewController" bundle:nil];
    [itemsViewController setCompletionBlock:^(FDDPItem *item){
        NSMutableArray *items;
        
        items = [self.order.items mutableCopy];
        [items addObject:item];
        self.order.items = items;
        [self updateMealsAndItemsTextView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)removeWasPressed:(id)sender
{
    UINavigationController *navigationController;
    FDDPMealsAndItemsViewController *mealsAndItemsViewController;
    
    mealsAndItemsViewController = [[FDDPMealsAndItemsViewController alloc] initWithNibName:@"FDDPMealsAndItemsViewController" bundle:nil];
    mealsAndItemsViewController.order = self.order;
    [mealsAndItemsViewController setCompletionBlock:^{
        [self updateMealsAndItemsTextView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:mealsAndItemsViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma mark - Private Methods
- (void)setupUI
{
    if (self.isNewOrder) {
        self.orderIDLabel.text = @"New Order";
        self.deleteButton.hidden = YES;
    } else {
        self.orderIDLabel.text = [self.order.orderId stringValue];
        self.orderNotesTextView.text = self.order.orderNotes;
        self.deleteButton.hidden = NO;
    }
    
    [self.containerScrollView addSubview:self.containerView];
    [self.containerScrollView setContentSize:self.containerView.bounds.size];
    
    [self addBorderToTextViews];
    [self setupTargetActions];
    [self updateMealsAndItemsTextView];
}

- (void)setupTargetActions
{
    UITapGestureRecognizer *tapGestureRecongnizer;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWasPressed:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelWasPressed:)];
    
    tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finishEditing:)];
    [self.containerView addGestureRecognizer:tapGestureRecongnizer];
}

- (void)updateMealsAndItemsTextView
{
    NSString *mealsString;
    NSString *itemsString;
    
    mealsString = [[self.order.meals valueForKey:@"mealName"] componentsJoinedByString:@", "];
    itemsString = [[self.order.items valueForKey:@"itemName"] componentsJoinedByString:@", "];
    
    if (self.order.meals.count && self.order.items.count) {
        self.mealsAndItemsTextView.text = [@[mealsString, itemsString] componentsJoinedByString:@", "];
    } else if (self.order.meals.count && !self.order.items.count) {
        self.mealsAndItemsTextView.text = mealsString;
    } else if (!self.order.meals.count && self.order.items.count) {
        self.mealsAndItemsTextView.text = itemsString;
    } else {
        self.mealsAndItemsTextView.text = @"";
    }
}

- (void)addBorderToTextViews
{
    self.orderNotesTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.orderNotesTextView.layer.borderWidth = 1;
    
    self.mealsAndItemsTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mealsAndItemsTextView.layer.borderWidth = 1;
}

- (void)callCompletionBlock
{
    if (self.completionBlock) {
        self.completionBlock();
    }
}

@end
