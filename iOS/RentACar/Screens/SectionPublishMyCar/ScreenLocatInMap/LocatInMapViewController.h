//
//  LocatInMapViewController.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseViewController.h"

@protocol TapCoordinatesDelegate <NSObject>

- (void) mapWasTappedinLocation:(CLLocationCoordinate2D) coordinates;

@end

@interface LocatInMapViewController : BaseViewController

- (void) showPins:(NSMutableArray*) pins;

@property (nonatomic,assign) id<TapCoordinatesDelegate> tapDelegate;

@end
