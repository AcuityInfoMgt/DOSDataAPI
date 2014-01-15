//
//  DOSTermItem.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/14/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSDataAPIElement.h"

@interface DOSTermItem : DOSDataAPIElement

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;

-(void) mapAPIResponseToProperties:(NSDictionary *)apiItemData;

@end
