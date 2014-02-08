//
//  DOSSecretaryAppointmentManager.m
//  DOSDataAPI
//
//  Created by Kevin Ferrell on 1/11/14.
//  Copyright (c) 2014 Acuity Inc.
//

#import "DOSSecretaryAppointmentManager.h"
#import "AFNetworking.h"
#import "DOSSecretaryAppointmentItem.h"

@interface DOSSecretaryAppointmentManager()

@property (nonatomic, strong) NSString *secretaryAppointmentsRequestCommand;
@property (nonatomic, strong) NSDictionary *secretaryAppointmentsQueryDefaultOptions;

@end

@implementation DOSSecretaryAppointmentManager

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.secretaryAppointmentsRequestCommand = @"get_appt_schedules";
        
        // Set the default query options for secretary travel
        NSMutableDictionary *queryOptions = [[NSMutableDictionary alloc] init];
        [queryOptions setObject:[NSNumber numberWithInt:100] forKey:DOSQueryArgPerPage];
        [queryOptions setObject:@"id,title,mobile_url,date" forKey:DOSQueryArgFields];
        self.secretaryAppointmentsQueryDefaultOptions = queryOptions;
        
        // Set the default record count
        self.recordCountReturned = [NSNumber numberWithInt:0];
    }
    
    return self;
}

-(void) getSecretaryAppointmentsWithOptions:(NSDictionary*)queryOptions success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Use the default query options if none were provided
    if (!queryOptions) {
        queryOptions = self.secretaryAppointmentsQueryDefaultOptions;
    }
    
    // Generate a query string from the options
    NSString *queryStringParameters = [DOSDataAPI buildURLQueryStringFromOptions:queryOptions];
    
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@",kAPIBaseURL,self.secretaryAppointmentsRequestCommand];
    
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
                NSArray *secretaryAppointmentData = [self convertSecretaryAppointmentsResponseToArray:responseObject];
                successBlock(secretaryAppointmentData);
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

-(NSArray*) convertSecretaryAppointmentsResponseToArray:(NSDictionary *)jsonResponse
{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [jsonResponse objectForKey:@"appt_schedules"];
    
    for (NSDictionary *item in responseData)
    {
        DOSSecretaryAppointmentItem *apptItem = [[DOSSecretaryAppointmentItem alloc] init];
        [apptItem mapAPIResponseToProperties:item];
        [responseArray addObject:apptItem];
    }
    
    return responseArray;
}

@end
