//
//  FDDPWebServicesManager.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

@class FDDPOrder;

typedef void(^FDDPWebServicesFetchOrdersCompletionBlock)(NSArray *orders, NSError *error);
typedef void(^FDDPWebServicesOrderCompletionBlock)(NSString *message, NSError *error);

typedef void (^FDDPWebServicesFetchMealsCompletionBlock)(NSArray *meals, NSError *error);

typedef void (^FDDPWebServicesFetchItemsCompletionBlock)(NSArray *items, NSError *error);

@interface FDDPWebServicesManager : NSObject

- (void)fetchAllOrders:(FDDPWebServicesFetchOrdersCompletionBlock)completion;
- (void)createOrder:(FDDPOrder *)order withCompletion:(FDDPWebServicesOrderCompletionBlock)completionBlock;
- (void)updateOrder:(FDDPOrder *)order withCompletion:(FDDPWebServicesOrderCompletionBlock)completionBlock;
- (void)deleteOrder:(FDDPOrder *)order withCompletion:(FDDPWebServicesOrderCompletionBlock)completionBlock;

- (void)fetchAllMeals:(FDDPWebServicesFetchMealsCompletionBlock)completion;

- (void)fetchAllItems:(FDDPWebServicesFetchItemsCompletionBlock)completion;

@end
