//
//  DOSTermManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/14/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

#import "DOSTermManager.h"
#import "AFNetworking.h"
#import "DOSTermItem.h"

@interface DOSTermManager()

@property (nonatomic, strong) NSString *TermRequestCommand;
@property (nonatomic, strong) NSDictionary *TermQueryDefaultOptions;

@end

@implementation DOSTermManager

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.TermRequestCommand = @"get_terms";
        
        // Set the default query options for secretary travel
        NSMutableDictionary *queryOptions = [[NSMutableDictionary alloc] init];
        [queryOptions setObject:[NSNumber numberWithInt:0] forKey:DOSQueryArgPage];
        [queryOptions setObject:[NSNumber numberWithInt:100] forKey:DOSQueryArgPerPage];
        self.TermQueryDefaultOptions = queryOptions;
        
        // Set the default record count
        self.recordCountReturned = [NSNumber numberWithInt:0];
    }
    
    return self;
}

-(void) getTermsWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Use the default query options if none were provided
    if (!queryOptions) {
        queryOptions = self.TermQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@",kAPIBaseURL,self.TermRequestCommand];
    
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
            
            NSArray *termData = [self convertTermResponseToArray:responseObject];
            successBlock(termData);
            
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

-(NSArray*) convertTermResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"terms"];
    
    for (NSDictionary *item in responseData)
    {
        DOSTermItem *termItem = [[DOSTermItem alloc] init];
        [termItem mapAPIResponseToProperties:item];
        [responseArray addObject:termItem];
    }
    
    return responseArray;
}


@end
