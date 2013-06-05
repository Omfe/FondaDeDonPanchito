//
//  FDDPOrder.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "FDDPOrder.h"
#import "FDDPMeal.h"
#import "FDDPItem.h"
#import "NSString+FDDPAdditions.h"

@implementation FDDPOrder

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    FDDPMeal *meal;
    FDDPItem *item;
    NSMutableArray *meals;
    NSMutableArray *items;
    
    self.orderId = dictionary[@"id"];
    self.orderedAt = [dictionary[@"orderedAt"] dateFromServerString];
    
    if (dictionary[@"orderNotes"] != [NSNull null]) {
        self.orderNotes = dictionary[@"orderNotes"];
    } else {
        self.orderNotes = @"";
    }
    
    meals = [NSMutableArray array];
    for (NSDictionary *mealsDictionary in dictionary[@"meals"]) {
        meal = [[FDDPMeal alloc] init];
//        [meal updateFromDictionary:mealsDictionary];
        [meals addObject:meal];
    }
    self.meals = meals;
    
    items = [NSMutableArray array];
    for (NSDictionary *itemsDictionary in dictionary[@"items"]) {
        item = [[FDDPItem alloc] init];
//        [item updatFromDictionary:itemsDictionary];
        [items addObject:item];
    }
    self.items = items;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dictionary;
    NSMutableArray *mealIDs;
    NSMutableArray *itemIDs;
    
    dictionary = [[NSMutableDictionary alloc] init];
    dictionary[@"orderNotes"] = self.orderNotes;
    dictionary[@"orderedAt"] = [NSString serverStringFromDate:self.orderedAt];
    
    mealIDs = [NSMutableArray array];
    for (FDDPMeal *meal in self.meals) {
        [mealIDs addObject:meal.mealId];
    }
    dictionary[@"mealIds"] = mealIDs;
    
    itemIDs = [NSMutableArray array];
    for (FDDPItem *item in self.items) {
        [itemIDs addObject:item.itemId];
    }
    dictionary[@"mealIds"] = itemIDs;
    
    return dictionary;
}

@end