//
//  DOSSecretaryAppointmentManager.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/11/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import <Foundation/Foundation.h>
#import "DOSDataAPI.h"

@interface DOSSecretaryAppointmentManager : NSObject

// Total record count for the last dataset queried
@property (nonatomic) NSNumber *recordCountReturned;

// **** Available Query Options for Secretary Appointment Schedule Data ****

// DOSQueryArgPerPage - Records Per Page (Default = 100)
// DOSQueryArgPage - Page to return (Default = 0)
// DOSQueryArgFields - Optional Fields id, title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,terms
//                     Default = id, title, mobile_url, date
// DOSQueryArgID - Filter by ID including ranges
// DOSQueryArgDate - Filter by date including ranges
// DOSQueryArgTerms - Filter for terms

-(void) getSecretaryAppointmentsWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;

@end
