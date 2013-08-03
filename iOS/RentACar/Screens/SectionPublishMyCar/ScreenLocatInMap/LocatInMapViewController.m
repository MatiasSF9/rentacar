//
//  LocatInMapViewController.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "LocatInMapViewController.h"

@interface LocatInMapViewController () {
      IBOutlet MKMapView* mapview;
}

@property (nonatomic, retain) NSMutableArray* currentPins;

@end

@implementation LocatInMapViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    //Add a gesture recognizer for user tap recognition
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(handleGesture:)];
    tgr.numberOfTapsRequired = 1;
    [mapview addGestureRecognizer:tgr];
    
    if(self.currentPins) {
        [self showPins:self.currentPins];
    }
    
    [super viewDidLoad];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    //When user finishes the tap, convert the point to lat lon cordinates
    CGPoint touchPoint = [gestureRecognizer locationInView:mapview];
    CLLocationCoordinate2D coordinate = [mapview convertPoint:touchPoint toCoordinateFromView:mapview];
    
    //Inform delegate about the change in map tap.
    if(self.tapDelegate) {
        [self.tapDelegate mapWasTappedinLocation:coordinate];
        [self showPins:[[NSMutableArray alloc] initWithObjects:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude], nil]];
    }
}

#pragma mark - MKMapViewDelegate

#pragma mark - MKMapViewDelegate

- (void) showPins:(NSMutableArray*) pins {
    [mapview removeAnnotations:self.currentPins];
    self.currentPins = [NSMutableArray arrayWithCapacity:pins.count];
    
    for(CLLocation* location in pins) {
        MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
        
        CLLocationCoordinate2D coord = [location coordinate];
        
        pin.coordinate = coord;
        pin.title = NSLocalizedString(@"Here's your car", @"Here's your car" );
        pin.subtitle = @"";
        
        [self.currentPins addObject:pin];
        [mapview addAnnotation:pin];
    }
    
    [self zoomMapToPins];
}

- (void) zoomMapToPins
{
    if (!self.currentPins || self.currentPins.count == 0)
    {
        return;
    }
    
    // determine the extents of the trip points that were passed in, and zoom in to that area.
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 90;
	CLLocationDegrees minLon = 180;
	
    for (MKPointAnnotation* pin in self.currentPins)
	{
		CLLocationCoordinate2D coord = pin.coordinate;
        
		if(coord.latitude > maxLat)
			maxLat = coord.latitude;
		if(coord.latitude < minLat)
			minLat = coord.latitude;
		if(coord.longitude > maxLon)
			maxLon = coord.longitude;
		if(coord.longitude < minLon)
			minLon = coord.longitude;
	}
	
    //Adds a bit of space to avoid zooming too close
    if([self.currentPins count] == 1) {
        maxLon += 0.002;
        minLon -= 0.002;
        maxLat += 0.002;
        minLat -= 0.002;
    }
    
	MKCoordinateRegion region;
	region.center.latitude = (maxLat + minLat) / 2;
	region.center.longitude = (maxLon + minLon) / 2;
    
    region.span.latitudeDelta = (maxLat - minLat)*1.05;
    region.span.longitudeDelta = (maxLon - minLon)*1.05;

	[mapview setRegion:region animated:YES];
}

@end
