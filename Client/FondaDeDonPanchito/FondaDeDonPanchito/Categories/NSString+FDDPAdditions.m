//
//  NSString+FDDPAdditions.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "NSString+FDDPAdditions.h"

@implementation NSString (FDDPAdditions)

#pragma mark - Public Methods
- (NSString *)stringByAddingURLParameters:(NSDictionary *)urlParameters
{
    NSString *parametersString;
    NSMutableArray *parametersArray;
    NSString *value;
    NSString *key;
    
    parametersArray = [NSMutableArray array];
    for (key in [urlParameters allKeys]) {
        value = urlParameters[key];
        [parametersArray addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    
    parametersString = [parametersArray componentsJoinedByString:@"&"];
    return [self stringByAppendingFormat:@"?%@", parametersString];
}

+ (NSString *)serverStringFromDate:(NSDate *)date
{
    return [[[self class] serverDateFormatter] stringFromDate:date];
}

- (NSDate *)dateFromServerString
{
    return [[[self class] serverDateFormatter] dateFromString:self];
}


#pragma mark - Private Methods
+ (NSDateFormatter *)serverDateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    
    if ( !dateFormatter ) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return dateFormatter;
}

@end
