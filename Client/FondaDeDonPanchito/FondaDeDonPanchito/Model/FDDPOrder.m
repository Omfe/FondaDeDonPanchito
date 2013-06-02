//
//  FDDPOrder.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrder.h"

@implementation FDDPOrder

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    self.orderId = dictionary[@"orderId"];
    self.orderName = dictionary[@"orderName"];
    self.orderNotes = dictionary[@"orderNotes"];
    self.orderedAt = dictionary[@"orderedAt"];
    self.clientId = dictionary[@"clientId"];
}

@end
