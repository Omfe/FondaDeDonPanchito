//
//  FDDPWebServicesManager.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

typedef void (^FDDPWebServicesFetchOrdersCompletionBlock)(NSArray *orders, NSError *error);

@interface FDDPWebServicesManager : NSObject

- (void)fetchAllOrders:(FDDPWebServicesFetchOrdersCompletionBlock)completion;

@end
