//
//  DOSTIPReportItem.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/11/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import "DOSTIPReportItem.h"

@implementation DOSTIPReportItem

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
    self.terms = [apiItemData objectForKey:@"terms"];
    self.year = [apiItemData objectForKey:@"year"];
}

@end
