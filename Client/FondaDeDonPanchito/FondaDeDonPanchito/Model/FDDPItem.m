//
//  FDDPItem.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPItem.h"

@implementation FDDPItem

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    self.itemId = dictionary[@"id"];
    self.itemName = dictionary[@"itemName"];
    self.itemPrice = dictionary[@"itemPrice"];
    self.isActive = dictionary[@"isActive"];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dictionary;
    
    dictionary = [[NSMutableDictionary alloc] init];
    dictionary[@"id"] = self.itemId;
    dictionary[@"itemName"] = self.itemName;
    dictionary[@"itemPrice"] = self.itemPrice;
    dictionary[@"isActive"] = self.isActive;
    
    return dictionary;   
}

@end