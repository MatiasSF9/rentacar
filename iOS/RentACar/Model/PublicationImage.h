//
//  PublicationImage.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PublicationImage : NSObject

@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, retain) NSData* imageContent;

@end
