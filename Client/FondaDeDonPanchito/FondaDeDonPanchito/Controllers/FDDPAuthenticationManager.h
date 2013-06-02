//
//  FDDPAuthenticationController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPUser.h"

extern NSString *FDDPServerError;

typedef void(^FDDPAuthenticationLoginCompletionBlock)(NSString *message, NSError *error);
typedef void (^FDDPAuthenticationLogoutCompletionBlock)(NSString *message, NSError *error);

@interface FDDPAuthenticationManager : NSObject

@property (strong, nonatomic) FDDPUser *loggedInUser;

+ (FDDPAuthenticationManager *)sharedManager;

- (void)loginWithUsername:(NSString *)username withPassword:(NSString *)password andCompletion:(FDDPAuthenticationLoginCompletionBlock)completion;
- (void)logoutWithCompletion:(FDDPAuthenticationLogoutCompletionBlock)completion;

@end