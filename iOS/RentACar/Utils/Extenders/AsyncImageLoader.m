//
//  AsyncImageLoader.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "AsyncImageLoader.h"
#import "DiskCache.h"

#define DEFAULT_WIDTH           320
#define DEFAULT_HEIGHT          320
#define DEFAULT_QUALITY         1
#define DEFAULT_SIZE            640

@implementation UIImageView (AsyncImageLoader)

- (void) dealloc {
    [NSThread cancelPreviousPerformRequestsWithTarget:self];
}

- (UIImage *)makeResizedImage:(UIImage*)imagen :(CGSize)newSize quality:(CGInterpolationQuality)interpolationQuality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = imagen.CGImage ;
    
    // Compute the bytes per row of the new image
    size_t bytesPerRow = CGImageGetBitsPerPixel(imageRef) / CGImageGetBitsPerComponent(imageRef) * newRect.size.width;
    bytesPerRow = (bytesPerRow + 15) & ~15;// Make it 16-byte aligned
    
    // Build a bitmap context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                bytesPerRow,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef resizedImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(resizedImageRef);
    
    return resizedImage;
}


- (void) setImageURL: (NSURL*) url placeHolder: (UIImage *) image usingCache: (BOOL) withCache{
    
    //Set placeholder image
    [self setImage:image];
    
    if (!url)
        return;
    
    //Cancel any previous request
    [NSThread cancelPreviousPerformRequestsWithTarget:self];
    
    if (withCache)
        //Start new Thread with cache
        [NSThread  detachNewThreadSelector:@selector(startWithCache:) toTarget:self withObject:url];
    else
        //Start new Thread without cache
        [NSThread  detachNewThreadSelector:@selector(startWithoutCache:) toTarget:self withObject:url];
}

- (CGSize) getOptimalSize: (UIImage*) image {
    
    //Reduce the size of the image
    long int width = image.size.width;
    long int height = image.size.height;
    double sup = height + width;
    
    double reductionPercent = DEFAULT_QUALITY;
    
    if (sup > DEFAULT_SIZE){
        
        reductionPercent = DEFAULT_SIZE / sup;
        
    }
    
    return CGSizeMake(width * reductionPercent, height * reductionPercent);
}

- (float) getOptimalQuality : (UIImage*) image {
    
    return DEFAULT_QUALITY;
}


- (void) startWithCache: (NSURL*) url {
    
    UIImage *img = [[DiskCache sharedDiskCache] imageFromKey:[url absoluteString]];
    
    if (img){
        
        [self setImage:img];
        
    }else{
        
        //Make the request
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: url];
        
        UIImage* aux_image = [UIImage imageWithData: imageData];
        
        //UIIMAGE size and quality
        CGSize size = [self getOptimalSize:   aux_image];
        int quality = [self getOptimalQuality:aux_image];
        
        //Save the resized image
        if(size.width != aux_image.size.width || size.height != aux_image.size.height) {
            aux_image = [self makeResizedImage:[UIImage imageWithData: imageData]
                                              :size
                                       quality:quality];
        }
        
        // Check error
        if (aux_image != nil){
            
            // Store the image in the disk
            if ([[url absoluteString] rangeOfString:@".png"].location == NSNotFound){
                [[DiskCache sharedDiskCache]  storeImage:aux_image
                                                   imageData:UIImageJPEGRepresentation(aux_image, quality)
                                                      forKey:[url absoluteString]];
            }else{
                [[DiskCache sharedDiskCache]  storeImage:aux_image
                                                   imageData:UIImagePNGRepresentation(aux_image)
                                                      forKey:[url absoluteString]];
            }
            [self setImage: aux_image];
            
        }
    }
}

- (void) startWithoutCache: (NSURL*) url {
    //Make the request
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: url];
    
    UIImage* aux_image = [UIImage imageWithData: imageData];
    
    //UIIMAGE size and quality
    CGSize size = [self getOptimalSize:   aux_image];
    int quality = [self getOptimalQuality:aux_image];
    
    //Save the resized image
    if(size.width != aux_image.size.width || size.height != aux_image.size.height) {
        aux_image = [self makeResizedImage:[UIImage imageWithData: imageData]
                                          :size
                                   quality:quality];
    }
    
    // Check error
    if (aux_image != nil){
        [self setImage: aux_image];
    }
}

@end
