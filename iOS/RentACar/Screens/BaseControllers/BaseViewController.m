//
//  BaseViewController.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


//Handles memory managment
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self freeResources];
}

- (void) freeResources {
}

@end
