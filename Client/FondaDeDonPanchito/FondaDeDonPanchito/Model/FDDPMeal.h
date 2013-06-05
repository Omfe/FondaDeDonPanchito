//
//  FDDPMeal.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDPMeal : NSObject

@property (strong, nonatomic) NSNumber *mealId;
@property (strong, nonatomic) NSNumber *mealPrice;
@property (strong, nonatomic) NSString *mealName;
@property (strong, nonatomic) NSNumber *isActive;

- (void)updateFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryRepresentation;

@end
