//
//  DOSSecretaryTravelDataManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 12/27/13.
//  Copyright (c) 2014 Acuity Inc.
//

#import "DOSSecretaryTravelDataManager.h"
#import "AFNetworking.h"
#import "DOSSecretaryTravelItem.h"
#import "DOSSecretaryTravelDetailItem.h"
#import "DOSSecretaryTravelStatsItem.h"

@interface DOSSecretaryTravelDataManager()

@property (nonatomic, strong) NSString *secretaryTravelRequestCommand;
@property (nonatomic, strong) NSString *secretaryTravelDetailRequestCommand;
@property (nonatomic, strong) NSString *secretaryTravelStatsCommand;
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
        self.secretaryTravelStatsCommand = @"get_secretary_travel_stats";
        
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
        
        // Set the default record count
        self.recordCountReturned = [NSNumber numberWithInt:0];
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
        
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success intValue] == 1) {
            
            // Set the record count returned
            self.recordCountReturned = [responseObject objectForKey:@"total_record_count"];
            
            if ([self.recordCountReturned intValue] > 0) {
                NSArray *secretaryTravelData = [self convertSecretaryTravelResponseToArray:responseObject];
                successBlock(secretaryTravelData);
            }
            else
            {
                // Return an empty array
                successBlock([[NSArray alloc] init]);
            }
            
        }
        else
        {
            self.recordCountReturned = [NSNumber numberWithInt:0];
            NSDictionary *details = [NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"message"],NSLocalizedDescriptionKey, nil];
            NSError *error = [NSError errorWithDomain:@"gov.state.DOSDataAPI" code:200 userInfo:details];
            failureBlock(error);
        }
        
    
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
        queryOptions = self.secretaryTravelDetailQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@&ref_id=%@",kAPIBaseURL,self.secretaryTravelDetailRequestCommand,itemID];
    
    if (queryStringParameters.length > 0)
    {
        query = [NSString stringWithFormat:@"%@&%@",query,queryStringParameters];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:query parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success intValue] == 1) {
            
            // Set the record count returned
            self.recordCountReturned = [responseObject objectForKey:@"total_record_count"];
            
            if ([self.recordCountReturned intValue] > 0) {
                NSArray *secretaryTravelDetailData = [self convertSecretaryTravelDetailResponseToArray:responseObject];
                successBlock(secretaryTravelDetailData);
            }
            else
            {
                // Return an empty array
                successBlock([[NSArray alloc] init]);
            }
            
        }
        else
        {
            self.recordCountReturned = [NSNumber numberWithInt:0];
            NSDictionary *details = [NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"message"],NSLocalizedDescriptionKey, nil];
            NSError *error = [NSError errorWithDomain:@"gov.state.DOSDataAPI" code:200 userInfo:details];
            failureBlock(error);
        }
        
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

-(void) getSecretaryTravelStatsWithSuccess:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
     // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@",kAPIBaseURL,self.secretaryTravelStatsCommand];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:query parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *success = [responseObject objectForKey:@"success"];
        if ([success intValue] == 1) {
            
            // Set the record count returned
            self.recordCountReturned = [responseObject objectForKey:@"total_record_count"];
            
            if ([self.recordCountReturned intValue] > 0) {
                NSArray *secretaryTravelStatsData = [self convertSecretaryTravelStatsResponseToArray:responseObject];
                successBlock(secretaryTravelStatsData);
            }
            else
            {
                // Return an empty array
                successBlock([[NSArray alloc] init]);
            }
            
        }
        else
        {
            self.recordCountReturned = [NSNumber numberWithInt:0];
            NSDictionary *details = [NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"message"],NSLocalizedDescriptionKey, nil];
            NSError *error = [NSError errorWithDomain:@"gov.state.DOSDataAPI" code:200 userInfo:details];
            failureBlock(error);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        failureBlock(error);
        
    }];
}

-(NSArray*) convertSecretaryTravelStatsResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"travel_stats"];
    
    for (NSDictionary *item in responseData)
    {
        DOSSecretaryTravelStatsItem *travelStats = [[DOSSecretaryTravelStatsItem alloc] init];
        [travelStats mapAPIResponseToProperties:item];
        [responseArray addObject:travelStats];
    }
    
    return responseArray;
}


@end
