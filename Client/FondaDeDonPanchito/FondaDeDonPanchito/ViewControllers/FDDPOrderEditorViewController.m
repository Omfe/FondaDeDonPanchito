//
//  FDDPOrderEditorViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrderEditorViewController.h"

@interface FDDPOrderEditorViewController ()

@property(weak, nonatomic) IBOutlet UITextField *orderName;
@property(weak, nonatomic) IBOutlet UITextView *orderNotes;
@property(weak, nonatomic) IBOutlet UIDatePicker *orderedAt;

@end

@implementation FDDPOrderEditorViewController

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

@end
