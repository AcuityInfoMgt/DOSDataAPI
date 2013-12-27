//
//  DOSDataAPI.h
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/26/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOSDataAPI : NSObject

// Define success/failure block types
typedef void (^ APISuccessBlock)(id);

- (NSString *) helloWorld;
- (void) testNetworking:(APISuccessBlock)successBlock;

@end
