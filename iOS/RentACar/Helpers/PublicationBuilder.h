//
//  PublicationBuilder.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol PublicationBuildStatusDelegate <NSObject>

- (void) didEndPublishing;

@end

//Builder Object for managing the Publication creation lifecycle
//It also works as a Singleton, use sharedInstance methos to call it.
@interface PublicationBuilder : NSObject

+ (PublicationBuilder*) sharedInstance;

//Setters
- (void) setPublicationDescription:(NSString*) description;
- (void) setPublicationTitle:(NSString*) title;
- (void) setPublicationContactNumber:(NSString*) contactNumber;
- (void) setPublicationUsername:(NSString*) username;
- (void) setPublicationCostPerDay:(NSNumber*) costPerDay;
- (void) setCurrentCarLocation:(CLLocationCoordinate2D) location;

//Getters
- (NSString*) getPublicationDescription;
- (NSString*) getPublicationTitle;
- (NSString*) getPublicationContactNumber;
- (NSString*) getPublicationUsername;
- (NSNumber*) getPublicationCostPerDay;
- (CLLocationCoordinate2D) getCurrentCarLocation;

//Adds image to publication.
//Returns: NO if no image couldn't be added or YES if image was added succesfully.
- (BOOL) addImageToPublicationWithTitle:(NSString*) title
                            description:(NSString*) description
                             inLocation:(CLLocationCoordinate2D) location
                       withImageRawData:(NSData*) data;
    
//Final build Method. Only call when Publication is confirmed by the user.
- (void) buildReportingStatusToDelegate:(id<PublicationBuildStatusDelegate>) delegate;

//Clears all the data currently associated and creates a new object reay to receive data.
- (void) clearCurrentBuild;

- (NSArray*) getCurrentPublicationImages;

@end
