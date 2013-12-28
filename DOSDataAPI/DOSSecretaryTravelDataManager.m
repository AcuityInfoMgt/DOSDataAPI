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

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.requestCommand = @"get_secretary_travel";
        self.itemsPerPage = 100;
        self.resultFields = @"id,title,mobile_url,date_start,date_end";
    }
    
    return self;
}

-(void) getSecretaryTravelForPage:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@&per_page=%ld&page=%ld&fields=%@",kAPIBaseURL,self.requestCommand,(long)self.itemsPerPage,(long)pageNum,self.resultFields];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:query parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *secretaryTravelData = [self convertResponseToArray:responseObject];
        successBlock(secretaryTravelData);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        failureBlock(error);
    
    }];
}

-(NSArray*) convertResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray;
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"secretary_travel"];
    
    for (NSDictionary *item in responseData)
    {
        DOSSecretaryTravelItem *travelItem = [[DOSSecretaryTravelItem alloc] init];
        [travelItem mapAPIResponseToProperties:item];
        [responseArray addObject:travelItem];
    }
    
    return responseArray;
}


@end
