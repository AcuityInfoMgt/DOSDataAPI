//
//  DOSCountryFactSheetItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/13/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import <Foundation/Foundation.h>
#import "DOSDataAPIElement.h"

@interface DOSCountryFactSheetItem : DOSDataAPIElement

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentHtml;
@property (nonatomic, strong) NSString *fullUrl;
@property (nonatomic, strong) NSString *fullHtml;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSDate   *date;
@property (nonatomic, strong) NSString *terms;
@property (nonatomic, strong) NSString *bureau;
@property (nonatomic, strong) NSString *officialName;

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData;

@end
