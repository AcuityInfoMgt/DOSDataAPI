//
//  DOSSecretaryTravelStatsItem.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/9/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSSecretaryTravelStatsItem.h"

@implementation DOSSecretaryTravelStatsItem

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData
{
    self.flightTimeHours = [apiItemData objectForKey:@"flight_time_hrs"];
    self.milage = [apiItemData objectForKey:@"mileage"];
    self.countriesVisited = [apiItemData objectForKey:@"countries_visited"];
    self.travelDays = [apiItemData objectForKey:@"travel_days"];

}

@end
