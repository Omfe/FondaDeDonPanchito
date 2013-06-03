//
//  FDDPOrderEditorViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrderEditorViewController.h"
#import "FDDPOrder.h"

@interface FDDPOrderEditorViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (weak, nonatomic) IBOutlet UITextField *orderNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *orderNotesTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *orderedAtDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

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
    if (0) { // Change to if buttonIndex is the cancel one
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
    if (self.order) {
        // Call update WebService
    } else {
        // Call create WebService
    }
    [self callCompletionBlock];
}

- (IBAction)cancelWasPressed:(id)sender
{
    [self callCompletionBlock];
}

- (IBAction)deleteWasPressed:(id)sender
{
    // Present Action sheet
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
        self.orderedAtDatePicker.date = self.order.orderedAt;
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
