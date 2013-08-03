//
//  DiskCache.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>


//Use the sharedDiskCahce method as a Singleton for this class
@interface DiskCache : NSObject

+ (DiskCache*) sharedDiskCache;

//make an image copy to the device disk
- (void)storeImage:(UIImage *)image imageData:(NSData *)data forKey:(NSString *)key;
//Use this method to get the image, the "key" is the image url
- (UIImage *)imageFromKey:(NSString *)key;

- (void)removeImageForKey:(NSString *)key;
- (void)cleanDisk;

@end
