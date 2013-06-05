//
//  FDDPMeal.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPMeal.h"

@implementation FDDPMeal

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    self.mealId = dictionary[@"id"];
    self.mealPrice = dictionary[@"mealPrice"];
    self.mealName = dictionary[@"mealName"];
    self.isActive = dictionary[@"isActive"];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dictionary;
    
    dictionary = [[NSMutableDictionary alloc] init];
    dictionary[@"id"] = self.mealId;
    dictionary[@"mealPrice"] = self.mealPrice;
    dictionary[@"mealName"] = self.mealName;
    dictionary[@"isActive"] = self.isActive;
    
    return dictionary;
}

@end
