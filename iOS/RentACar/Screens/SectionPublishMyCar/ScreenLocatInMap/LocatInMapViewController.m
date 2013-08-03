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

@end

@implementation LocatInMapViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    CLLocationCoordinate2D location;
    
    location.latitude = 22.569722 ;
    location.longitude = 88.369722;
    
    [self displayRegion:location];
    
    //Add a gesture recognizer for user tap recognition
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(handleGesture:)];
    tgr.numberOfTapsRequired = 1;
    [mapview addGestureRecognizer:tgr];
    
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
        [self displayRegion:coordinate];
    }
}


-(void)displayRegion:(CLLocationCoordinate2D) coordinate
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    region.span=span;
    
    region.center=coordinate;
    
    [mapview setRegion:region animated:TRUE];
    [mapview regionThatFits:region];
}

#pragma mark - MKMapViewDelegate

@end
