//
//  FDDPAuthenticationController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPAuthenticationManager.h"
#import "FDDPUser.h"
#import "NSString+FDDPAdditions.h"

#define kServerURL @"http://localhost:4567"

@interface FDDPAuthenticationManager ()

@end

@implementation FDDPAuthenticationManager

static FDDPAuthenticationManager *_sharedAuthenticationManager = nil;
+ (FDDPAuthenticationManager *)sharedManager
{
    if (!_sharedAuthenticationManager) {
        _sharedAuthenticationManager = [[FDDPAuthenticationManager alloc] init];
    }
    return _sharedAuthenticationManager;
}

#pragma mark - Public Methods
- (void)loginWithUsername:(NSString *)username withPassword:(NSString *)password andCompletion:(FDDPAuthenticationLoginCompletionBlock)completion
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    NSData *bodyData;
    NSDictionary *bodyDictionary;
    
    
    urlString = [kServerURL stringByAppendingPathComponent:@"login"];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    bodyDictionary = @{ @"username": username, @"password": password };
    bodyData = [NSJSONSerialization dataWithJSONObject:bodyDictionary options:0 error:nil];
    [urlRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error) {
        NSDictionary *responseDictionary;
        
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (!self.loggedInUser) {
            self.loggedInUser = [[FDDPUser alloc] init];
        }
        [self.loggedInUser updateFromDictionary:responseDictionary[@"user"]];
        
        if (completion) {
            completion(responseDictionary[@"message"], nil);
        }
    }];
}

- (void)logoutWithToken:(NSString *)token andCompletion:(FDDPAuthenticationLogoutCompletionBlock)completion
{
    NSMutableURLRequest *urlRequest;
    NSURL *url;
    NSString *urlString;
    NSDictionary *urlParameters;
    
    urlParameters = @{ @"token": token };
    
    urlString = [kServerURL stringByAppendingPathComponent:@"logout"];
    urlString = [urlString stringByAddingURLParameters:urlParameters];
    url = [NSURL URLWithString:urlString];
    urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
        NSDictionary *responseDictionary;
        
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.loggedInUser = nil;
        
        if (completion) {
            completion(responseDictionary[@"message"], nil);
        }
    }];
}

@end
