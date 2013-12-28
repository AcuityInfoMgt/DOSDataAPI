//
//  DOSDataAPI.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/26/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// **** Set API end point URL
#define kAPIBaseURL @"http://www.state.gov/api/v1"

// **** Define query success/failure block types ****
typedef void (^ APISuccessBlock)(NSArray*);
typedef void (^ APIFailureBlock)(NSError*);

// **** Import State.gov Data SDK classes ****
#import "DOSSecretaryTravelDataManager.h"

@interface DOSDataAPI : NSObject

@end
