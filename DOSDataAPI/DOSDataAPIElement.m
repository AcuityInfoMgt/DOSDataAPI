//
//  DOSDataAPIElement.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/8/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import "DOSDataAPIElement.h"

@implementation DOSDataAPIElement

- (NSDate*)convertResponseElementToDateForKey:(NSString *)responseKey withResponse:(NSDictionary *)responseData
{
    NSString *stringVal = [responseData objectForKey:responseKey];
    
    if (stringVal) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateVal = [dateFormat dateFromString:stringVal];
        return dateVal;
    }
    else
    {
        // Return nil if the key isn't present in the response
        return nil;
    }
}

@end
