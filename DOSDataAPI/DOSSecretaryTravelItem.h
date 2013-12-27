//
//  DOSSecretaryTravelItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOSSecretaryTravelItem : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *siteUrl;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentHtml;
@property (nonatomic, strong) NSString *fullUrl;
@property (nonatomic, strong) NSString *fullHtml;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *dateStart;
@property (nonatomic, strong) NSString *dateEnd;
@property (nonatomic, strong) NSString *terms;


@end
