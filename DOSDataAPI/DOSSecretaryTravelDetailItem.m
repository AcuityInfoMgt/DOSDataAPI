//
//  DOSSecretaryTravelDetailItem.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import "DOSSecretaryTravelDetailItem.h"

@implementation DOSSecretaryTravelDetailItem

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData
{
    self.itemId = [apiItemData objectForKey:@"id"];
    self.title = [apiItemData objectForKey:@"title"];
    self.siteUrl = [apiItemData objectForKey:@"site_url"];
    self.contentUrl = [apiItemData objectForKey:@"content_url"];
    self.contentHtml = [apiItemData objectForKey:@"content_html"];
    self.fullUrl = [apiItemData objectForKey:@"full_url"];
    self.fullHtml = [apiItemData objectForKey:@"full_html"];
    self.mobileUrl = [apiItemData objectForKey:@"mobile_url"];
    self.date = [apiItemData objectForKey:@"date"];
    self.terms = [apiItemData objectForKey:@"terms"];
}

@end
