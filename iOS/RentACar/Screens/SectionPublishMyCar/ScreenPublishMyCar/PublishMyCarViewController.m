//
//  PublishMyCarViewController.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublishMyCarViewController.h"
#import "PublicationPreviewViewController.h"

@interface PublishMyCarViewController ()

@end

@implementation PublishMyCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"My Car", @"My Car");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

#pragma Mark - IBActions

- (IBAction) openPreview:(id)sender {
    [self.navigationController pushViewController:[[PublicationPreviewViewController alloc] initWithNibName:@"PublicationPreviewViewController" bundle:nil]
                                         animated:YES];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
