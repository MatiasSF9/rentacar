//
//  RentACarTests.m
//  RentACarTests
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "RentACarTests.h"
#import "PublicationBuilder.h"
#import <CoreLocation/CoreLocation.h>

@implementation RentACarTests

- (void)setUp
{
    [super setUp];
    //Here goes all setup code for each test.
    
    //Makes the singleton initialize and get cleared on each run, to avoid side effects
    [[PublicationBuilder sharedInstance] clearCurrentBuild];
}

- (void)tearDown
{
    // Tear-down code here. Nothing needs to be done
    
    [super tearDown];
}

- (void)testBuilderAddImageSuccesfullyAdded
{
    CLLocationCoordinate2D location = [[[CLLocation alloc] initWithLatitude:-43.002322 longitude:-43.21212] coordinate];
    STAssertTrue([[PublicationBuilder sharedInstance] addImageToPublicationWithTitle:@"aTitle"
                                                                         description:@"aDescription" inLocation:location withImageRawData:[[NSData alloc] init]],  @"testBuilderAddImageSuccesfullyAdded FAILED");
}

- (void)testBuilderAddImageSuccesfullyWithoutDescription
{
    CLLocationCoordinate2D location = [[[CLLocation alloc] initWithLatitude:-43.002322 longitude:-43.21212] coordinate];
    STAssertTrue([[PublicationBuilder sharedInstance] addImageToPublicationWithTitle:@"aTitle"
                                                                         description:nil
                                                                         inLocation:location withImageRawData:[[NSData alloc] init]],  @"testBuilderAddImageSuccesfullyWithoutDescription FAILED");
}

- (void)testBuilderAddImageFailureForImageMissing
{
    CLLocationCoordinate2D location = [[[CLLocation alloc] initWithLatitude:-43.002322 longitude:-43.21212] coordinate];
    STAssertFalse([[PublicationBuilder sharedInstance] addImageToPublicationWithTitle:@"aTitle"
                                                                         description:@"aDescription"
                                                                          inLocation:location withImageRawData:nil],@"testBuilderAddImageFailureForImageMissing FAILED");
}

@end
