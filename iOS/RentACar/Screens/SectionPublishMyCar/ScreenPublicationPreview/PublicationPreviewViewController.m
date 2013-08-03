//
//  PublicationPreviewViewController.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublicationPreviewViewController.h"
#import "PublicationBuilder.h"
#import "Publication.h"
#import "ImageCarouselView.h"

@interface PublicationPreviewViewController () {
    IBOutlet ImageCarouselView *carouselView;
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblDescription;
    IBOutlet UILabel *lblUserNmae;
    IBOutlet UILabel *lblContactNumber;
    IBOutlet UILabel *lblRentalFee;
    
}

@end

@implementation PublicationPreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Publication Preview", @"Publication Preview");
        [self.navigationController hidesBottomBarWhenPushed];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    lblTitle.text = [[PublicationBuilder sharedInstance] getPublicationTitle];
    lblDescription.text =[[PublicationBuilder sharedInstance] getPublicationDescription];
    lblUserNmae.text = [[PublicationBuilder sharedInstance] getPublicationUsername];
    lblContactNumber.text =[[PublicationBuilder sharedInstance] getPublicationContactNumber];
    lblRentalFee.text = [[[PublicationBuilder sharedInstance] getPublicationCostPerDay] stringValue];
    
    NSArray *images = [[PublicationBuilder sharedInstance] getCurrentPublicationImages];
    if (images.count) {
        [carouselView setPublicationImages: images];
    } else {
        [carouselView setHidden: YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
