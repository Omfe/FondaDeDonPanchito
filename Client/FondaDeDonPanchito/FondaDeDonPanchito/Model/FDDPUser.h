//
//  FDDPUser.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDPUser : NSObject

@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSNumber *isAdmin;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSString *token;

- (void)updateFromDictionary:(NSDictionary *)dictionary;

@end
