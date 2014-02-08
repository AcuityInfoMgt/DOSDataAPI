//
//  DOSSecretaryTravelStatsItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/9/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import "DOSDataAPIElement.h"

@interface DOSSecretaryTravelStatsItem : DOSDataAPIElement

@property (nonatomic, strong) NSNumber *flightTimeHours;
@property (nonatomic, strong) NSNumber *milage;
@property (nonatomic, strong) NSNumber *countriesVisited;
@property (nonatomic, strong) NSNumber *travelDays;

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData;

@end
