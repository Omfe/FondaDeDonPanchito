//
//  FDDPWebServicesManager.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPWebServicesManager.h"
#import "FDDPOrder.h"   
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
    urlString = [urlString stringByAppendingPathComponent:[order.orderId stringValue]];
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
@end

//hmmm nah creo que si cambian varias cosas: http method, el urlString tiene que mandar id como parte del url "orders/2", y después de lo del statusCode] == 400, es igual al logout pero sin eso de self.loggedInUser = nil


