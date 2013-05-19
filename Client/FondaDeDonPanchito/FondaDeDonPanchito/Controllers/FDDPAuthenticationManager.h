//
//  FDDPAuthenticationController.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/17/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

typedef void(^FDDPAuthenticationLoginCompletionBlock)(NSString *message, NSError *error);

@interface FDDPAuthenticationManager : NSObject

+ (FDDPAuthenticationManager *)sharedManager;

- (void)loginWithUsername:(NSString *)username withPassword:(NSString *)password andCompletion:(FDDPAuthenticationLoginCompletionBlock)completion;

@end
