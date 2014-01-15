//
//  DOSTermItem.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/14/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSTermItem.h"

@implementation DOSTermItem

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData
{
    self.name = [apiItemData objectForKey:@"name"];
    self.description = [apiItemData objectForKey:@"description"];
}

@end
