//
//  DOSSecretaryTravelItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2014 Acuity Inc.
//

#import <Foundation/Foundation.h>
#import "DOSDataAPIElement.h"

@interface DOSSecretaryTravelItem : DOSDataAPIElement

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentHtml;
@property (nonatomic, strong) NSString *fullUrl;
@property (nonatomic, strong) NSString *fullHtml;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, strong) NSString *terms;

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData;

@end
