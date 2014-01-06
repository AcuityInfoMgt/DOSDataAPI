//
//  DOSDataAPI.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/26/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import "DOSDataAPI.h"
#import "AFNetworking.h"

NSString *const DOSQueryArgPerPage = @"per_page";
NSString *const DOSQueryArgPage = @"page";
NSString *const DOSQueryArgFields = @"fields";
NSString *const DOSQueryArgID = @"id";
NSString *const DOSQueryArgDate = @"date";
NSString *const DOSQueryArgTerms = @"terms";

@implementation DOSDataAPI

+ (NSString*)buildURLQueryStringFromOptions:(NSDictionary *)queryOptions
{
    NSMutableString *queryString = [[NSMutableString alloc] init];
    
    for (NSString *key in queryOptions) {
        id value = [queryOptions objectForKey:key];
        
        // Convert any non-strings to strings
        if ([value class] != [NSString class]) {
            value = [value stringValue];
        }
        
        // Add a seperator if needed
        if (queryString.length > 0) {
            [queryString appendString:@"&"];
        }
        
        // Add the query parameter
        [queryString appendFormat:@"%@=%@",key,value];
    }
    
    return queryString;
}

@end
