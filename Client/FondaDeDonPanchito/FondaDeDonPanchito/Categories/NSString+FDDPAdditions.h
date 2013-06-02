//
//  NSString+FDDPAdditions.h
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

@interface NSString (FDDPAdditions)

- (NSString *)stringByAddingURLParameters:(NSDictionary *)urlParameters;
+ (NSString *)serverStringFromDate:(NSDate *)date;
- (NSDate *)dateFromServerString;

@end
