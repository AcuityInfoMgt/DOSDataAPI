//
//  DOSDataAPI.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/26/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// **** Set API end point URL ****
#define kAPIBaseURL @"http://www.state.gov/api/v1"

// **** Define query success/failure block types ****
typedef void (^ APISuccessBlock)(NSArray*);
typedef void (^ APIFailureBlock)(NSError*);

// **** Define query argument attributes - used to include query options ***
extern NSString *const DOSQueryArgPerPage;
extern NSString *const DOSQueryArgPage;
extern NSString *const DOSQueryArgFields;
extern NSString *const DOSQueryArgID;
extern NSString *const DOSQueryArgDate;
extern NSString *const DOSQueryArgTerms;

// **** Import State.gov Data SDK classes ****
#import "DOSSecretaryTravelDataManager.h"

@interface DOSDataAPI : NSObject

// Prepare query string parameter options
+ (NSString*)buildURLQueryStringFromOptions:(NSDictionary *)queryOptions;

@end
