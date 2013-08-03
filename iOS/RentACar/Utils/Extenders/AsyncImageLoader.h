//
//  AsyncImageLoader.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

@interface UIImageView (AsyncImageLoader)

//Set the image frame before calling this method
//Automatically handles image download showing the placeholder image in the meanwhile.
- (void) setImageURL: (NSURL*) url placeHolder: (UIImage *) image usingCache: (BOOL) withCache;

@end
