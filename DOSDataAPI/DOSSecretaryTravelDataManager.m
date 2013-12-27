//
//  DOSSecretaryTravelDataManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import "DOSSecretaryTravelDataManager.h"
#import "AFNetworking.h"

@implementation DOSSecretaryTravelDataManager

#define kSecretaryTravelCommand @"get_secretary_travel"

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.itemsPerPage = 100;
        self.resultFields = @"id,title,mobile_url,date_start,date_end";
    }
    
    return self;
}

-(void) getSecretaryTravelForPage:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Format the query string
    //NSString *query = [NSString stringWithFormat:@"%@?command=%@&per_page=%ld&page=%ld&fields=%@",kAPIBaseURL,kSecretaryTravelCommand,self.itemsPerPage,pageNum,self.resultFields];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"command",kSecretaryTravelCommand,@"per_page",self.itemsPerPage,@"page",pageNum,@"fields",self.resultFields, nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kAPIBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failureBlock(error);
    }];
}


@end
