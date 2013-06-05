//
//  FDDPItemsViewController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//
@class FDDPItem;

@interface FDDPItemsViewController : UIViewController

typedef void (^FDDPItemsViewControllerCompletionBlock)(FDDPItem *item);

@property (copy, nonatomic) FDDPItemsViewControllerCompletionBlock completionBlock;

@end
