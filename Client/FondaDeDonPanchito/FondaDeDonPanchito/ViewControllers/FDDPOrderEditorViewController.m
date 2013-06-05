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

@property (nonatomic, strong) NSMutableArray *orderObjectsArray;

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
    
    [self setupUI];
}


#pragma mark - UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FDDPWebServicesManager *webServicesManager;
    
    if (buttonIndex == 1) {
        return;
    }
    
    if (self.order) {
        webServicesManager = [[FDDPWebServicesManager alloc] init];
        [webServicesManager deleteOrder:self.order withCompletion:^(NSString *message, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    }
    [self callCompletionBlock];
}


#pragma mark - Action Methods
- (IBAction)doneWasPressed:(id)sender
{
    FDDPWebServicesManager *webServicesManager;
    FDDPOrder *order;
    
    webServicesManager = [[FDDPWebServicesManager alloc] init];
    
    if (self.order) {
        self.order.orderNotes = self.orderNotesTextView.text;
        
        [webServicesManager updateOrder:self.order withCompletion:^(NSString *message, NSError *error) {
            [self callCompletionBlock];
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    } else {
        order = [[FDDPOrder alloc] init];
        order.orderedAt = [NSDate date];
        order.orderNotes = self.orderNotesTextView.text;
        
        [webServicesManager createOrder:order withCompletion:^(NSString *message, NSError *error) {
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
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:mealsViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)addItemWasPressed:(id)sender
{
    UINavigationController *navigationController;
    FDDPItemsViewController *itemsViewController;
    
    itemsViewController = [[FDDPItemsViewController alloc] initWithNibName:@"FDDPItemsViewController" bundle:nil];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)removeWasPressed:(id)sender
{
    UINavigationController *navigationController;
    FDDPMealsAndItemsViewController *mealsAndItemsViewController;
    
    mealsAndItemsViewController = [[FDDPMealsAndItemsViewController alloc] initWithNibName:@"FDDPMealsAndItemsViewController" bundle:nil];
    mealsAndItemsViewController.orderObjectsArray = self.orderObjectsArray;
    [mealsAndItemsViewController setCompletionBlock:^{
        // Reload the string
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:mealsAndItemsViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma mark - Private Methods
- (void)setupUI
{
    if (self.order) {
        self.orderIDLabel.text = [self.order.orderId stringValue];
        self.orderNotesTextView.text = self.order.orderNotes;
        self.deleteButton.hidden = NO;
    } else {
        self.orderIDLabel.text = @"New Order";
        self.deleteButton.hidden = YES;
    }
    
    [self.containerScrollView addSubview:self.containerView];
    [self.containerScrollView setContentSize:self.containerView.bounds.size];
    
    [self addBorderToTextViews];
    [self setupTargetActions];
}

- (void)setupTargetActions
{
    UITapGestureRecognizer *tapGestureRecongnizer;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWasPressed:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelWasPressed:)];
    
    tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finishEditing:)];
    [self.containerView addGestureRecognizer:tapGestureRecongnizer];
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
