//
//  FDDPOrder.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrder.h"
#import "NSString+FDDPAdditions.h"

@implementation FDDPOrder

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    self.orderId = dictionary[@"id"];
    self.orderedAt = [dictionary[@"orderedAt"] dateFromServerString];
    
    if (dictionary[@"orderNotes"] != [NSNull null]) {
        self.orderNotes = dictionary[@"orderNotes"];
    } else {
        self.orderNotes = @"";
    }
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dictionary;
    
    dictionary = [[NSMutableDictionary alloc] init];
    dictionary[@"orderNotes"] = self.orderNotes;
    dictionary[@"orderedAt"] = [NSString serverStringFromDate:self.orderedAt];
    
    return dictionary;
}

@end