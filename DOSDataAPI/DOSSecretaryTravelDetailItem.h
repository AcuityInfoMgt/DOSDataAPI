//
//  DOSSecretaryTravelDetailItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOSSecretaryTravelDetailItem : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentHtml;
@property (nonatomic, strong) NSString *fullUrl;
@property (nonatomic, strong) NSString *fullHtml;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *terms;

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData;

@end
