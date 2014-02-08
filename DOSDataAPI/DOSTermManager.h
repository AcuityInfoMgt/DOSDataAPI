//
//  DOSTermManager.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/14/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import <Foundation/Foundation.h>
#import "DOSDataAPI.h"

@interface DOSTermManager : NSObject

// Total record count for the last dataset queried
@property (nonatomic) NSNumber *recordCountReturned;

// **** Available Query Options for TIP Report Data ****

// DOSQueryArgPerPage - Records Per Page (Default = 100)
// DOSQueryArgPage - Page to return (Default = 0)
// NOTE: NO OTHER QUERY FIELDS ARE NOT SUPPORTED

-(void) getTermsWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;

@end
