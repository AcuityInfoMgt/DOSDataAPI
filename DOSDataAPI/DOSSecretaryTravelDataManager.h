//
//  DOSSecretaryTravelDataManager.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOSDataAPI.h"

@interface DOSSecretaryTravelDataManager : NSObject

// Total record count for the last dataset queried
@property (nonatomic) NSNumber *recordCountReturned;

// **** Available Query Options for Secretary Travel Data ****

// DOSQueryArgPerPage - Records Per Page (Default = 100)
// DOSQueryArgPage - Page to return (Default = 0)
// DOSQueryArgFields - Optional Fields id, title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,date_start,date_end,terms
//                     Default = id, title, mobile_url, date_start, date_end
// DOSQueryArgID - Filter by ID including ranges
// DOSQueryArgDate - Filter by date including ranges
// DOSQueryArgTerms - Filter for terms

-(void) getSecretaryTravelWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;


// **** Available Query Options for Secretary Travel DETAIL Data ****

// Options Same as above except for DOSQueryArgFields:
// Default = id, title, mobile_url, date
// Other Options: id, title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,terms

-(void) getSecretaryTravelDetailForItem:(NSString*)itemID withOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;


// **** Secretary Travel Stats ****

-(void) getSecretaryTravelStatsWithSuccess:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;

@end
