//
//  DOSDataAPITests.m
//  DOSDataAPITests
//
//  Created by Kevin Ferrell on 12/26/13.
//  Copyright (c) 2013 Acuity Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DOSDataAPI.h"
#import "XCTestCase+AsyncTesting.h"
#import "DOSSecretaryTravelItem.h"
#import "DOSSecretaryTravelStatsItem.h"
#import "DOSSecretaryAppointmentItem.h"
#import "DOSSecretaryAppointmentManager.h"

@interface DOSDataAPITests : XCTestCase

@end

@implementation DOSDataAPITests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Tests the parsing of the Secretary Travel Response
- (void)testSecretaryTravel
{
    DOSSecretaryTravelDataManager *dataMan = [[DOSSecretaryTravelDataManager alloc] init];
    [dataMan getSecretaryTravelWithOptions:nil success:^(NSArray *response) {
        
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Travel Test");
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        XCTFail(@"Secretary Travel Error: %@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:5];
}

// Tests the conversion of JSON response to Obj-C objects
- (void)testSecretaryTravelResponseConversion
{
    DOSSecretaryTravelDataManager *dataMan = [[DOSSecretaryTravelDataManager alloc] init];
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"id,title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,date_start,date_end,terms" forKey:DOSQueryArgFields];
    [options setObject:[NSNumber numberWithInt:1] forKey:DOSQueryArgPerPage];
    
    [dataMan getSecretaryTravelWithOptions:options success:^(NSArray *response) {
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Travel Full Field Test");

        // Test each field for data
        DOSSecretaryTravelItem *item = response[0];
        XCTAssertNotNil(item.itemId, @"Secretary Travel Response Parse Failed For: itemID");
        XCTAssertNotNil(item.title, @"Secretary Travel Response Parse Failed For: title");
        XCTAssertNotNil(item.siteUrl, @"Secretary Travel Response Parse Failed For: siteUrl");
        XCTAssertNotNil(item.contentUrl, @"Secretary Travel Response Parse Failed For: contentUrl");
        XCTAssertNotNil(item.contentHtml, @"Secretary Travel Response Parse Failed For: contentHtml");
        XCTAssertNotNil(item.fullUrl, @"Secretary Travel Response Parse Failed For: fullUrl");
        XCTAssertNotNil(item.fullHtml, @"Secretary Travel Response Parse Failed For: fullHtml");
        XCTAssertNotNil(item.mobileUrl, @"Secretary Travel Response Parse Failed For: mobileUrl");
        XCTAssertNotNil(item.date, @"Secretary Travel Response Parse Failed For: date");
        XCTAssertNotNil(item.dateStart, @"Secretary Travel Response Parse Failed For: dateStart");
        XCTAssertNotNil(item.dateEnd, @"Secretary Travel Response Parse Failed For: dateEnd");
        XCTAssertNotNil(item.terms, @"Secretary Travel Response Parse Failed For: terms");
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        XCTFail(@"Secretary Travel Error: %@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}

// Tests the Secretary Travel Detail interface
- (void)testSecretaryTravelDetail
{
    DOSSecretaryTravelDataManager *dataMan = [[DOSSecretaryTravelDataManager alloc] init];
    [dataMan getSecretaryTravelDetailForItem:@"10060804" withOptions:nil success:^(NSArray *response) {
        
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Travel Detail Test");
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        XCTFail(@"Secretary Travel Detail Error: %@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:5];
}

// Tests the Secretary Travel Stats interface
-(void)testSecretaryTravelStatsResponse
{
    DOSSecretaryTravelDataManager *dataMan = [[DOSSecretaryTravelDataManager alloc] init];
    [dataMan getSecretaryTravelStatsWithSuccess:^(NSArray *response) {
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Travel Stats Test");
        
        // Test each field for data
        DOSSecretaryTravelStatsItem *item = response[0];
        XCTAssertNotNil(item.flightTimeHours, @"Secretary Travel Stats Response Parse Failed For: flightTimeHours");
        XCTAssertNotNil(item.milage, @"Secretary Travel Stats Response Parse Failed For: milage");
        XCTAssertNotNil(item.countriesVisited, @"Secretary Travel Stats Response Parse Failed For: countriesVisited");
        XCTAssertNotNil(item.travelDays, @"Secretary Travel Stats Response Parse Failed For: travelDays");
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        XCTFail(@"Secretary Travel Stats Error: %@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}

// Tests the parsing of the Secretary Travel Schedule Response
- (void)testSecretaryAppointmentSchedule
{
    DOSSecretaryAppointmentManager *dataMan = [[DOSSecretaryAppointmentManager alloc] init];
    [dataMan getSecretaryAppointmentsWithOptions:nil success:^(NSArray *response) {
        
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Appointment Test");
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        XCTFail(@"Secretary Appointment Schedule Error: %@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:5];
}

// Tests the conversion of JSON response to Obj-C objects
- (void)testSecretaryAppointmentResponseConversion
{
    DOSSecretaryAppointmentManager *dataMan = [[DOSSecretaryAppointmentManager alloc] init];
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"id,title,site_url,content_url,content_html,full_url,full_html,mobile_url,date,terms" forKey:DOSQueryArgFields];
    [options setObject:[NSNumber numberWithInt:1] forKey:DOSQueryArgPerPage];
    
    [dataMan getSecretaryAppointmentsWithOptions:options success:^(NSArray *response) {
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Appointment Full Field Test");
        
        // Test each field for data
        DOSSecretaryAppointmentItem *item = response[0];
        XCTAssertNotNil(item.itemId, @"Secretary Appointment Response Parse Failed For: itemID");
        XCTAssertNotNil(item.title, @"Secretary Appointment Response Parse Failed For: title");
        XCTAssertNotNil(item.siteUrl, @"Secretary Appointment Response Parse Failed For: siteUrl");
        XCTAssertNotNil(item.contentUrl, @"Secretary Appointment Response Parse Failed For: contentUrl");
        XCTAssertNotNil(item.contentHtml, @"Secretary Appointment Response Parse Failed For: contentHtml");
        XCTAssertNotNil(item.fullUrl, @"Secretary Appointment Response Parse Failed For: fullUrl");
        XCTAssertNotNil(item.fullHtml, @"Secretary Appointment Response Parse Failed For: fullHtml");
        XCTAssertNotNil(item.mobileUrl, @"Secretary Appointment Response Parse Failed For: mobileUrl");
        XCTAssertNotNil(item.date, @"Secretary Appointment Response Parse Failed For: date");
        XCTAssertNotNil(item.terms, @"Secretary Appointment Response Parse Failed For: terms");
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        XCTFail(@"Secretary Appointment Error: %@", error);
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}


@end
