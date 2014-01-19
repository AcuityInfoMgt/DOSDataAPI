//
//  DOSBureauManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/14/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSBureauManager.h"
#import "AFNetworking.h"
#import "DOSBureauItem.h"

@interface DOSBureauManager()

@property (nonatomic, strong) NSString *BureauRequestCommand;
@property (nonatomic, strong) NSDictionary *BureauQueryDefaultOptions;

@end

@implementation DOSBureauManager

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.BureauRequestCommand = @"get_bureaus";
        
        // Set the default query options for secretary travel
        NSMutableDictionary *queryOptions = [[NSMutableDictionary alloc] init];
        [queryOptions setObject:[NSNumber numberWithInt:0] forKey:DOSQueryArgPage];
        [queryOptions setObject:[NSNumber numberWithInt:100] forKey:DOSQueryArgPerPage];
        self.BureauQueryDefaultOptions = queryOptions;
        
        // Set the default record count
        self.recordCountReturned = [NSNumber numberWithInt:0];
    }
    
    return self;
}

-(void) getBureausWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Use the default query options if none were provided
    if (!queryOptions) {
        queryOptions = self.BureauQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@",kAPIBaseURL,self.BureauRequestCommand];
    
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
                NSArray *bureauData = [self convertBureauResponseToArray:responseObject];
                successBlock(bureauData);
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

-(NSArray*) convertBureauResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"bureaus"];
    
    for (NSDictionary *item in responseData)
    {
        DOSBureauItem *bureauItem = [[DOSBureauItem alloc] init];
        [bureauItem mapAPIResponseToProperties:item];
        [responseArray addObject:bureauItem];
    }
    
    return responseArray;
}

@end
