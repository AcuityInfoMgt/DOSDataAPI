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
        
        XCTAssertNotNil(response, @"API Did not Return a Result: Secretary Travel Default Test");
        
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

@end
