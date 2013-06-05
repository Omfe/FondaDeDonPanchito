//
//  FDDPOrder.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/7/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDPOrder : NSObject

@property (strong, nonatomic) NSNumber *orderId;
@property (strong, nonatomic) NSString *orderNotes;
@property (strong, nonatomic) NSDate *orderedAt;
@property (nonatomic, strong) NSArray *meals;
@property (nonatomic, strong) NSArray *items;

- (void)updateFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryRepresentation;

@end
