//
//  FDDPWebServicesManager.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPWebServicesManager.h"
#import "FDDPOrder.h"
#import "FDDPMeal.h"
#import "FDDPItem.h"
#import "FDDPAuthenticationManager.h"
#import "NSString+FDDPAdditions.h"

#define kServerURL @"http://localhost:4567"

@implementation FDDPWebServicesManager

- (void)fetchAllOrders:(FDDPWebServicesFetchOrdersCompletionBlock)completion
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"orders"];
    urlString = [urlString stringByAddingURLParameters:@{ @"token": [[FDDPAuthenticationManager sharedManager] loggedInUser].token }];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        NSMutableArray *orders;
        FDDPOrder *order;
        
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([(NSHTTPURLResponse *)urlResponse statusCode] == 400) {
            if (completion) {
                error = [[NSError alloc] initWithDomain:FDDPServerError code:400 userInfo:@{ NSLocalizedDescriptionKey: responseDictionary[@"message"] }];
                completion(nil, error);
            }
            return;
        }
        
        orders = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in responseDictionary[@"orders"]) {
            order = [[FDDPOrder alloc] init];
            [order updateFromDictionary:dictionary];
            [orders addObject:order];
        }
        
        if (completion) {
            completion(orders, nil);
        }
    }];
}

- (void)createOrder:(FDDPOrder *)order withCompletion:(FDDPWebServicesOrderCompletionBlock)completionBlock
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    NSData *bodyData;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"orders"];
    urlString = [urlString stringByAddingURLParameters:@{ @"token": [[FDDPAuthenticationManager sharedManager] loggedInUser].token }];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    bodyData = [NSJSONSerialization dataWithJSONObject:[order dictionaryRepresentation] options:0 error:nil];
    [urlRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        
        if (error) {
            if (completionBlock) {
                completionBlock(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([(NSHTTPURLResponse *)urlResponse statusCode] == 400) {
            if (completionBlock) {
                error = [[NSError alloc] initWithDomain:FDDPServerError code:400 userInfo:@{ NSLocalizedDescriptionKey: responseDictionary[@"message"] }];
                completionBlock(responseDictionary[@"message"], error);
            }
            return;
        }
        
        if (completionBlock) {
            completionBlock(responseDictionary[@"message"], nil);
        }
    }];
    
}

- (void)updateOrder:(FDDPOrder *)order withCompletion:(FDDPWebServicesOrderCompletionBlock)completionBlock
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    NSData *bodyData;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"orders"];
    urlString = [urlString stringByAppendingPathComponent:[order.orderId stringValue]];
    urlString = [urlString stringByAddingURLParameters:@{ @"token": [[FDDPAuthenticationManager sharedManager] loggedInUser].token }];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    
    bodyData = [NSJSONSerialization dataWithJSONObject:[order dictionaryRepresentation] options:0 error:nil];
    [urlRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        
        if (error) {
            if (completionBlock) {
                completionBlock(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([(NSHTTPURLResponse *)urlResponse statusCode] == 400) {
            if (completionBlock) {
                error = [[NSError alloc] initWithDomain:FDDPServerError code:400 userInfo:@{ NSLocalizedDescriptionKey: responseDictionary[@"message"] }];
                completionBlock(responseDictionary[@"message"], error);
            }
            return;
        }
        
        if (completionBlock) {
            completionBlock(responseDictionary[@"message"], nil);
        }
    }];
}

- (void)deleteOrder:(FDDPOrder *)order withCompletion:(FDDPWebServicesOrderCompletionBlock)completionBlock
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"orders"];
    urlString = [urlString stringByAppendingPathComponent:[order.orderId stringValue]];
    urlString = [urlString stringByAddingURLParameters:@{ @"token": [[FDDPAuthenticationManager sharedManager] loggedInUser].token }];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        
        if (error) {
            if (completionBlock) {
                completionBlock(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([(NSHTTPURLResponse *)urlResponse statusCode] == 400) {
            if (completionBlock) {
                error = [[NSError alloc] initWithDomain:FDDPServerError code:400 userInfo:@{ NSLocalizedDescriptionKey: responseDictionary[@"message"] }];
                completionBlock(responseDictionary[@"message"], error);
            }
            return;
        }
        
        if (completionBlock) {
            completionBlock(responseDictionary[@"message"], nil);
        }
    }];
}

- (void)fetchAllMeals:(FDDPWebServicesFetchMealsCompletionBlock)completion
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"meals"];
    urlString = [urlString stringByAddingURLParameters:@{ @"token": [[FDDPAuthenticationManager sharedManager] loggedInUser].token }];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        NSMutableArray *meals;
        FDDPMeal *meal;
        
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([(NSHTTPURLResponse *)urlResponse statusCode] == 400) {
            if (completion) {
                error = [[NSError alloc] initWithDomain:FDDPServerError code:400 userInfo:@{ NSLocalizedDescriptionKey: responseDictionary[@"message"] }];
                completion(nil, error);
            }
            return;
        }
        
        meals = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in responseDictionary[@"meals"]) {
            meal = [[FDDPMeal alloc] init];
            [meal updateFromDictionary:dictionary];
            [meals addObject:meal];
        }
        
        if (completion) {
            completion(meals, nil);
        }
    }];
    
}

- (void)fetchAllItems:(FDDPWebServicesFetchItemsCompletionBlock)completion
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"items"];
    urlString = [urlString stringByAddingURLParameters:@{ @"token": [[FDDPAuthenticationManager sharedManager] loggedInUser].token }];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        NSMutableArray *items;
        FDDPItem *item;
        
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([(NSHTTPURLResponse *)urlResponse statusCode] == 400) {
            if (completion) {
                error = [[NSError alloc] initWithDomain:FDDPServerError code:400 userInfo:@{ NSLocalizedDescriptionKey: responseDictionary[@"message"] }];
                completion(nil, error);
            }
            return;
        }
        
        items = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in responseDictionary[@"items"]) {
            item = [[FDDPItem alloc] init];
            [item updateFromDictionary:dictionary];
            [items addObject:item];
        }
        
        if (completion) {
            completion(items, nil);
        }
    }];
}

@end

