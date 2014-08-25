//
//  DOSSecretaryTravelStatsItem.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/9/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import "DOSSecretaryTravelStatsItem.h"

@implementation DOSSecretaryTravelStatsItem

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData
{
    self.flightTimeHours = [apiItemData objectForKey:@"flight_time_hrs"];
    self.milage = [apiItemData objectForKey:@"mileage"];
    self.countriesVisited = [apiItemData objectForKey:@"countries_visited"];
    self.travelDays = [apiItemData objectForKey:@"travel_days"];
    
    // This code attempts to correct for potential data entry errors in the mileage statistic
    if ([self.milage isKindOfClass:[NSString class]]) {
        NSString *mileageString = [apiItemData objectForKey:@"mileage"];
        mileageString = [mileageString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        self.milage = [formatter numberFromString:mileageString];
    }
    
    // This code attempts to correct for potential data entry errors in the flight time statistic
    if ([self.flightTimeHours isKindOfClass:[NSString class]]) {
        NSString *flightTimeString = [apiItemData objectForKey:@"flight_time_hrs"];
        flightTimeString = [flightTimeString stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        self.flightTimeHours = [formatter numberFromString:flightTimeString];
    }

}

@end
