//
//  FDDPWebServicesManager.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPWebServicesManager.h"

#define kServerURL @"http://localhost:4567"

@implementation FDDPWebServicesManager

- (void)fetchAllOrders:(FDDPWebServicesFetchOrdersCompletionBlock)completion
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    
    urlString = [kServerURL stringByAppendingPathComponent:@"orders"];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        if (completion) {
            completion(responseDictionary[@"message"], nil);
        }
    }];
}

@end
