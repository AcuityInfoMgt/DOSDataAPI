//
//  DOSSecretaryTravelDataManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import "DOSSecretaryTravelDataManager.h"
#import "AFNetworking.h"

#define kSecretaryTravelCommand @"get_secretary_travel"

@implementation DOSSecretaryTravelDataManager

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
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kSecretaryTravelCommand,@"command",self.itemsPerPage,@"per_page",pageNum,@"page",self.resultFields,@"fields",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kAPIBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failureBlock(error);
    }];
}


@end
