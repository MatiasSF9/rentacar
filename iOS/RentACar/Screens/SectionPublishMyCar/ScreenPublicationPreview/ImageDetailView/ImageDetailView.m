//
//  ImageDetailView.m
//  RentACar
//
//  Created by Matias Fernandez on 8/3/13.
//  Copyright (c) 2013 Matias Fernandez. All rights reserved.
//

#import "ImageDetailView.h"


@implementation ImageDetailView

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *viewFromXib =  [[NSBundle mainBundle] loadNibNamed:@"ImageDetailView"
                                                          owner:self options:nil];
        UIView *view = [viewFromXib objectAtIndex:0];
        [self addSubview:view];
    }
    return self;
}

@end
