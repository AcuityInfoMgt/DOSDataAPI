//
//  DOSCountryFactSheetManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/13/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSCountryFactSheetManager.h"
#import "AFNetworking.h"
#import "DOSCountryFactSheetItem.h"

@interface DOSCountryFactSheetManager()

@property (nonatomic, strong) NSString *CountryFactSheetsRequestCommand;
@property (nonatomic, strong) NSDictionary *CountryFactSheetsQueryDefaultOptions;

@end

@implementation DOSCountryFactSheetManager

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.CountryFactSheetsRequestCommand = @"get_country_fact_sheets";
        
        // Set the default query options for secretary travel
        NSMutableDictionary *queryOptions = [[NSMutableDictionary alloc] init];
        [queryOptions setObject:[NSNumber numberWithInt:100] forKey:DOSQueryArgPerPage];
        [queryOptions setObject:@"id,title,mobile_url,date" forKey:DOSQueryArgFields];
        self.CountryFactSheetsQueryDefaultOptions = queryOptions;
        
        // Set the default record count
        self.recordCountReturned = [NSNumber numberWithInt:0];
    }
    
    return self;
}

-(void) getCountryFactSheetsWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Use the default query options if none were provided
    if (!queryOptions) {
        queryOptions = self.CountryFactSheetsQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@",kAPIBaseURL,self.CountryFactSheetsRequestCommand];
    
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
                NSArray *countryFactSheetData = [self convertCountryFactSheetResponseToArray:responseObject];
                successBlock(countryFactSheetData);
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

-(NSArray*) convertCountryFactSheetResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"country_fact_sheets"];
    
    for (NSDictionary *item in responseData)
    {
        DOSCountryFactSheetItem *countryFactItem = [[DOSCountryFactSheetItem alloc] init];
        [countryFactItem mapAPIResponseToProperties:item];
        [responseArray addObject:countryFactItem];
    }
    
    return responseArray;
}


@end
