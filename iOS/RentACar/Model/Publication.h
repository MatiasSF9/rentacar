//
//  Publication.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Publication : NSObject

@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* contactNumber;
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSNumber* costPerDay;
@property (nonatomic, assign) CLLocationCoordinate2D carLocation;
@property (nonatomic, retain) NSMutableArray* images;

@end
