//
//  FDDPOrderEditorViewController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrder.h"

@interface FDDPOrderEditorViewController : UIViewController

typedef void(^FDDPOrderEditorCompletionBlock)();

@property (strong, nonatomic) FDDPOrder *order;
@property (assign, nonatomic) FDDPOrderEditorCompletionBlock completionBlock;

@end