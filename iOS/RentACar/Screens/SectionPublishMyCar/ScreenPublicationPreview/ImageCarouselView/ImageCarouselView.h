//
//  ImageCarouselView.h
//  RentACar
//
//  Created by Matias Fernandez on 8/3/13.
//  Copyright (c) 2013 Matias Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCarouselView : UIScrollView 


/*
 * INCOMPLETE FEATURE:
 * Adds images to scroll view using only 3 view and switching content between them
 * making the scroll apear infinite.
 */
- (void)setPublicationImages:(NSArray*) array;

/*
 * Works as a regular scroll view.
 */
- (void)setPublicationImagesForRegularScroll: (NSArray*) array;
@end
