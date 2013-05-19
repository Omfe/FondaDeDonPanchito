//
//  FDDPAuthenticationController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPAuthenticationController.h"

#define kServerURL @"http://localhost:4567"

@interface FDDPAuthenticationController ()

//

@end

@implementation FDDPAuthenticationController

static FDDPAuthenticationController *_sharedAuthenticationController = nil;
+ (FDDPAuthenticationController *)sharedAuthenticationController
{
    if (!_sharedAuthenticationController) {
        _sharedAuthenticationController = [[FDDPAuthenticationController alloc] init];
    }
    return _sharedAuthenticationController;
}

#pragma mark - Public Methods
- (void)loginWithUsername:(NSString *)username withPassword:(NSString *)password
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
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"Message: %@", responseDictionary[@"message"]);
        NSLog(@"Token: %@", responseDictionary[@"token"]);
    }];
}

@end
