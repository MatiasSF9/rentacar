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
    IBOutlet UIPageControl *pageControl;
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


- (void)setPublicationImagesForRegularScroll: (NSArray*) array {
    int position = 0;
    for (PublicationImage *image in array) {
        ImageDetailView *detail = [[ImageDetailView alloc] init];
        [detail configureCell: image];
        [detail setFrame: CGRectMake(IMAGE_CELL_WIDTH *position, 0, IMAGE_CELL_WIDTH, IMAGE_CELL_HEIGHT)];
        [self addSubview: detail];
        position++;
    }
    
    [pageControl setCurrentPage:0];
    [pageControl setNumberOfPages: position];
    self.contentSize = CGSizeMake(self.frame.size.width * position,
                                  self.frame.size.height);

}


- (void)setPublicationImages:(NSArray*) array {
    
    kNumberOfPages = array.count;
    publicationImages = array;
    imageB = [[ImageDetailView alloc] init];
    [imageB configureCell: [array objectAtIndex: 0]];
    [self addSubview: imageA];
    
    //The Scroll content will have as max width 3 pages since we will be reloading the views' contents.

    int scrollPages = kNumberOfPages > 3 ? 3 : kNumberOfPages;
    self.contentSize = CGSizeMake(self.frame.size.width * scrollPages,
                                  self.frame.size.height);
    [pageControl setCurrentPage:0];
    [pageControl setNumberOfPages: kNumberOfPages];
    
    if (kNumberOfPages>1) {
        [imageB setFrame: CGRectMake(IMAGE_CELL_WIDTH, 0, IMAGE_CELL_WIDTH, IMAGE_CELL_HEIGHT)];
        
        imageA = [[ImageDetailView alloc] init];
        [imageA setFrame: CGRectMake(0, 0, IMAGE_CELL_WIDTH, IMAGE_CELL_HEIGHT)];
        imageC= [[ImageDetailView alloc] init];
        [imageC setFrame: CGRectMake(IMAGE_CELL_WIDTH*2, 0, IMAGE_CELL_WIDTH, IMAGE_CELL_HEIGHT)];
        [self addSubview: imageB];
        [self addSubview: imageC];
        [self setScrollEnabled: YES];
        [self scrollToCenter];
    }
   
}

/*
 * When changing pages we always set the middle view to show the current page of
 * the carousel, with the previous and next page already loaded so the user can 
 * always scroll back and foward.
 */

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    [publicationImages objectAtIndex: page];
    
    int indexA;
    int indexB;
    int indexC;
    if (page == 0) {
        indexA = kNumberOfPages;
        indexB = page;
        indexC = page + 1;
    } else if(page == kNumberOfPages) {
        indexA = page - 1;
        indexB = kNumberOfPages;
        indexC = 0;
    } else {
        indexA = page - 1;
        indexB = page;
        indexC = page + 1;
    }
    
    [imageA configureCell: [publicationImages objectAtIndex: indexA]];
    [imageB configureCell: [publicationImages objectAtIndex: indexB]];
    [imageC configureCell: [publicationImages objectAtIndex: indexC]];
    [self scrollToCenter];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page < 0) {
        [self scrollToCenter];
        return;
    }
    else if (page > kNumberOfPages) {
        [self scrollToCenter];
        return;
    }
    
    pageControl.currentPage = page;
    [self loadScrollViewWithPage:page];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [self loadScrollViewWithPage:page];
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
}

- (void) scrollToCenter {
    [self scrollRectToVisible: CGRectMake(IMAGE_CELL_WIDTH, 0, IMAGE_CELL_WIDTH, IMAGE_CELL_HEIGHT) animated: NO];
}

@end
