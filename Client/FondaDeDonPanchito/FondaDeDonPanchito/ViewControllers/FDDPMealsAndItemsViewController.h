//
//  FDDPMealsAndItemsViewController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 6/3/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

typedef void(^FDDPMealsAndItemsCompletionBlock)();

@interface FDDPMealsAndItemsViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *orderObjectsArray;
@property (nonatomic, copy) FDDPMealsAndItemsCompletionBlock completionBlock;

@end
