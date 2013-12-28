//
//  DOSSecretaryTravelDataManager.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOSDataAPI.h"
#import "DOSSecretaryTravelItem.h"

@interface DOSSecretaryTravelDataManager : NSObject

// **** Properties to control query parameters ****

// Default = get_secretary_travel
@property (nonatomic, strong) NSString *requestCommand;

// Default = 100
@property (nonatomic) NSInteger itemsPerPage;

// Default = id, title, mobile_url, date_start, date_end
// Other Options: id, title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,date_start,date_end, terms
@property (nonatomic, strong) NSString *resultFields;

// **** Methods to obtain travel data ****

-(void) getSecretaryTravelForPage:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;


@end
