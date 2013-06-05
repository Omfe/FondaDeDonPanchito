//
//  FDDPMealsViewController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 6/3/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//
@class FDDPMeal;

@interface FDDPMealsViewController : UIViewController

typedef void (^FDDPMealsViewControllerCompletionBlock)(FDDPMeal *meal);

@property (copy, nonatomic) FDDPMealsViewControllerCompletionBlock completionBlock;

@end
