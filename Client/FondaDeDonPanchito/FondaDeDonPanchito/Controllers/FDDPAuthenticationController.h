//
//  FDDPAuthenticationController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

@interface FDDPAuthenticationController : NSObject

+ (FDDPAuthenticationController *)sharedAuthenticationController;

- (void)loginWithUsername:(NSString *)username withPassword:(NSString *)password;

@end
