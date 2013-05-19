//
//  FDDPAuthenticationController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPAuthenticationController.h"

static FDDPAuthenticationController *_sharedAuthenticationController = nil;

@implementation FDDPAuthenticationController

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
    
}

@end
