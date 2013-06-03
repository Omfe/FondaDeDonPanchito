//
//  FDDPWebServicesManager.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrder.h"

typedef void (^FDDPWebServicesFetchOrdersCompletionBlock)(NSArray *orders, NSError *error);

@interface FDDPWebServicesManager : NSObject

- (void)fetchAllOrders:(FDDPWebServicesFetchOrdersCompletionBlock)completion;
- (void)createOrder:(FDDPOrder *)order andCompletion:(FDDPWebServicesFetchOrdersCompletionBlock)completionBlock;
- (void)updateOrder:(FDDPOrder *)order andCompletion:(FDDPWebServicesFetchOrdersCompletionBlock)completionBlock;
- (void)deleteOrder:(FDDPOrder *)order andCompletion:(FDDPWebServicesFetchOrdersCompletionBlock)completionBlock;

@end
