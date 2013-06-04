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


@interface FDDPOrderEditorViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (weak, nonatomic) IBOutlet UITextField *orderNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *orderNotesTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) UIActionSheet *deleteActionSheet;

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
    if (buttonIndex == 1) { // Change to if buttonIndex is the cancel one
        return;
    }
    
    if (self.order) {
        // Call delete WebService
    }
    [self callCompletionBlock];
}


#pragma mark - Action Methods
- (IBAction)doneWasPressed:(id)sender
{
    FDDPWebServicesManager *webServicesManager;
    FDDPOrder *order;
    
    webServicesManager = [[FDDPWebServicesManager alloc] init];
    order = [[FDDPOrder alloc] init];
    order.orderName = self.orderNameTextField.text;
    order.orderNotes = self.orderNotesTextView.text;
    order.orderedAt = [NSDate date];
    
    if (self.order) {
        [webServicesManager updateOrder:order withCompletion:^(NSString *message, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    } else {
        [webServicesManager createOrder:order withCompletion:^(NSString *message, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"There was an error!" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            }
            [[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }];
    }
    [self callCompletionBlock];
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


#pragma mark - Private Methods
- (void)setupUI
{
    self.deleteButton.hidden = YES;
    if (self.order) {
        self.orderNameTextField.text = self.order.orderName;
        self.orderNotesTextView.text = self.order.orderNotes;
        self.deleteButton.hidden = NO;
    }
    
    [self.containerScrollView addSubview:self.containerView];
    [self.containerScrollView setContentSize:self.containerView.bounds.size];
    
    [self addBorderToOrderNotesTextView];
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

- (void)addBorderToOrderNotesTextView
{
    self.orderNotesTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.orderNotesTextView.layer.borderWidth = 1;
}

- (void)callCompletionBlock
{
    if (self.completionBlock) {
        self.completionBlock();
    }
}

@end
