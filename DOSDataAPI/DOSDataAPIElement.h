//
//  DOSDataAPIElement.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/8/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOSDataAPIElement : NSObject

// Convert API response from strings to NSDate
- (NSDate*)convertResponseElementToDateForKey:(NSString *)responseKey withResponse:(NSDictionary *)responseData;

@end
