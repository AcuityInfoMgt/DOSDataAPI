//
//  DOSSecretaryTravelDataManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import "DOSSecretaryTravelDataManager.h"
#import "AFNetworking.h"

@interface DOSSecretaryTravelDataManager()

@property (nonatomic, strong) NSString *secretaryTravelRequestCommand;
@property (nonatomic, strong) NSString *secretaryTravelDetailRequestCommand;
@property (nonatomic, strong) NSDictionary *secretaryTravelQueryDefaultOptions;
@property (nonatomic, strong) NSDictionary *secretaryTravelDetailQueryDefaultOptions;

@end


@implementation DOSSecretaryTravelDataManager

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.secretaryTravelRequestCommand = @"get_secretary_travel";
        self.secretaryTravelDetailRequestCommand = @"get_secretary_travel_detail";
        
        // Set the default query options for secretary travel
        NSMutableDictionary *queryOptions = [[NSMutableDictionary alloc] init];
        [queryOptions setObject:[NSNumber numberWithInt:100] forKey:DOSQueryArgPerPage];
        [queryOptions setObject:@"id,title,mobile_url,date_start,date_end" forKey:DOSQueryArgFields];
        self.secretaryTravelQueryDefaultOptions = queryOptions;
        
        // Set the default query options for secretary travel detail
        NSMutableDictionary *queryDetailOptions = [[NSMutableDictionary alloc] init];
        [queryDetailOptions setObject:[NSNumber numberWithInt:100] forKey:DOSQueryArgPerPage];
        [queryDetailOptions setObject:@"id,title,mobile_url,date" forKey:DOSQueryArgFields];
        self.secretaryTravelDetailQueryDefaultOptions = queryDetailOptions;
        
    }
    
    return self;
}

-(void) getSecretaryTravelWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Use the default query options if none were provided
    if (!queryOptions) {
        queryOptions = self.secretaryTravelQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@",kAPIBaseURL,self.secretaryTravelRequestCommand];
    
    if (queryStringParameters.length > 0)
    {
        query = [NSString stringWithFormat:@"%@&%@",query,queryStringParameters];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:query parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *secretaryTravelData = [self convertSecretaryTravelResponseToArray:responseObject];
        successBlock(secretaryTravelData);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        failureBlock(error);
    
    }];
}

-(NSArray*) convertSecretaryTravelResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"secretary_travel"];
    
    for (NSDictionary *item in responseData)
    {
        DOSSecretaryTravelItem *travelItem = [[DOSSecretaryTravelItem alloc] init];
        [travelItem mapAPIResponseToProperties:item];
        [responseArray addObject:travelItem];
    }
    
    return responseArray;
}


-(void) getSecretaryTravelDetailForItem:(NSString*)itemID withOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Use the default query options if none were provided
    if (!queryOptions) {
        queryOptions = self.secretaryTravelQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@&ref_id=%@%@",kAPIBaseURL,self.secretaryTravelDetailRequestCommand,itemID,queryStringParameters];
    
    if (queryStringParameters.length > 0)
    {
        query = [NSString stringWithFormat:@"%@&%@",query,queryStringParameters];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:query parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *secretaryTravelDetailData = [self convertSecretaryTravelDetailResponseToArray:responseObject];
        successBlock(secretaryTravelDetailData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        failureBlock(error);
        
    }];
}

-(NSArray*) convertSecretaryTravelDetailResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"secretary_travel_detail"];
    
    for (NSDictionary *item in responseData)
    {
        DOSSecretaryTravelDetailItem *travelDetailItem = [[DOSSecretaryTravelDetailItem alloc] init];
        [travelDetailItem mapAPIResponseToProperties:item];
        [responseArray addObject:travelDetailItem];
    }
    
    return responseArray;
}


@end
