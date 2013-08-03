//
//  ImageCarouselView.m
//  RentACar
//
//  Created by Matias Fernandez on 8/3/13.
//  Copyright (c) 2013 Matias Fernandez. All rights reserved.
//

#import "ImageCarouselView.h"
#import "PublicationImage.h"
#import "ImageDetailView.h"


@interface ImageCarouselView(){
    NSArray *publicationImages;
    ImageDetailView *imageA;
    ImageDetailView *imageB;
    ImageDetailView *imageC;
    UIPageControl *pageControl;
    int kNumberOfPages;
    BOOL pageControlUsed;
}
@end

@implementation ImageCarouselView

- (id)init
{
    self = [super init];
    if (self) {
        [self setShowsVerticalScrollIndicator: NO];
        [self setShowsHorizontalScrollIndicator: NO];
        [self setPagingEnabled: YES];
        pageControl = [[UIPageControl alloc] init];
    }
    return self;
}

- (void)setPublicationImages:(NSArray*) array {
    
    kNumberOfPages = array.count;
    publicationImages = array;
    imageB = [[ImageDetailView alloc] init];
    [imageB configureCell: [array objectAtIndex: 0]];
    [imageB setFrame: CGRectMake(0, 0, IMAGE_CELL_HEIGHT, IMAGE_CELL_WIDTH)];
    [self addSubview: imageA];
    
    if (kNumberOfPages>1) {
        imageA = [[ImageDetailView alloc] init];
        [imageA setFrame: CGRectMake(-IMAGE_CELL_WIDTH, 0, IMAGE_CELL_HEIGHT, IMAGE_CELL_WIDTH)];
        imageC= [[ImageDetailView alloc] init];
        [imageC setFrame: CGRectMake(IMAGE_CELL_WIDTH, 0, IMAGE_CELL_HEIGHT, IMAGE_CELL_WIDTH)];
        [self addSubview: imageB];
        [self addSubview: imageC];
    }
    
    [pageControl setCurrentPage:0];
    [pageControl setNumberOfPages: kNumberOfPages];
    
    self.contentSize = CGSizeMake(self.frame.size.width * kNumberOfPages,
                                  self.frame.size.height);
    
}


@end
