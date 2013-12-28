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
#import "DOSSecretaryTravelDetailItem.h"

@interface DOSSecretaryTravelDataManager : NSObject

// **** Properties to control query parameters ****

// Default = 100
@property (nonatomic) NSInteger itemsPerPage;

// Default = id, title, mobile_url, date_start, date_end
// Other Options: id, title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,date_start,date_end,terms
@property (nonatomic, strong) NSString *secretaryTravelResultFields;

// Default = id, title, mobile_url, date
// Other Options: id, title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,terms
@property (nonatomic, strong) NSString *secretaryTravelDetailResultFields;

// **** Methods to obtain travel data ****

-(void) getSecretaryTravelForPage:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;
-(void) getSecretaryTravelDetailForItem:(NSString*)itemID page:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock;


@end
