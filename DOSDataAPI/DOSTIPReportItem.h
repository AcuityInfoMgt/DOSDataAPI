//
//  DOSTIPReportItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/11/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSDataAPIElement.h"

@interface DOSTIPReportItem : DOSDataAPIElement

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentHtml;
@property (nonatomic, strong) NSString *fullUrl;
@property (nonatomic, strong) NSString *fullHtml;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSString *terms;

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData;

@end
