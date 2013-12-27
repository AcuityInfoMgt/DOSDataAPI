//
//  DOSDataAPI.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/26/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import "DOSDataAPI.h"
#import "AFNetworking.h"

@implementation DOSDataAPI

- (NSString *) helloWorld
{
    return @"Hello World";
}

- (void) testNetworking:(APISuccessBlock)successBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.state.gov/api/v1?command=get_secretary_travel&fields=title,mobile_url,id" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
