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

@end


@implementation DOSSecretaryTravelDataManager

-(id)init
{
    self = [super init];
    
    if (self) {
        // Set default query properties
        self.secretaryTravelRequestCommand = @"get_secretary_travel";
        self.secretaryTravelDetailRequestCommand = @"get_secretary_travel_detail";
        self.itemsPerPage = 100;
        self.secretaryTravelResultFields = @"id,title,mobile_url,date_start,date_end";
        self.secretaryTravelDetailResultFields = @"id,title,mobile_url,date";
    }
    
    return self;
}

-(void) getSecretaryTravelForPage:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@&per_page=%ld&page=%ld&fields=%@",kAPIBaseURL,self.secretaryTravelRequestCommand,(long)self.itemsPerPage,(long)pageNum,self.secretaryTravelResultFields];
    
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


-(void) getSecretaryTravelDetailForItem:(NSString*)itemID page:(NSInteger)pageNum success:(APISuccessBlock)successBlock failure:(APIFailureBlock)failureBlock
{
    // Format the query string
    NSString *query = [NSString stringWithFormat:@"%@?command=%@&ref_id=%@&per_page=%ld&page=%ld&fields=%@",kAPIBaseURL,self.secretaryTravelDetailRequestCommand,itemID,(long)self.itemsPerPage,(long)pageNum,self.secretaryTravelDetailResultFields];
    
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
