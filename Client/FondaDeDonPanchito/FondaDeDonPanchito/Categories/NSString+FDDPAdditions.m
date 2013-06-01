//
//  NSString+FDDPAdditions.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/31/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//

#import "NSString+FDDPAdditions.h"

@implementation NSString (FDDPAdditions)

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

@end
