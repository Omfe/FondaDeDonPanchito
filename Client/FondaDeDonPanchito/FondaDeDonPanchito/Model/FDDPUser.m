//
//  FDDPUser.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPUser.h"

@implementation FDDPUser

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    self.username = dictionary[@"username"];
    self.userId = dictionary[@"id"];
    self.firstName = dictionary[@"firstName"];
    self.isAdmin = dictionary[@"isAdmin"];
    self.password = dictionary[@"password"];
    self.lastname = dictionary[@"lastName"];
    self.token = dictionary[@"token"];
}

@end
