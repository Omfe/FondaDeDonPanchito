//
//  FDDPMealsAndItemsViewController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 6/3/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

@class FDDPOrder;

typedef void(^FDDPMealsAndItemsCompletionBlock)();

@interface FDDPMealsAndItemsViewController : UIViewController

@property (nonatomic, strong) FDDPOrder *order;
@property (nonatomic, copy) FDDPMealsAndItemsCompletionBlock completionBlock;

@end
