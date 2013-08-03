//
//  DiskCache.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "DiskCache.h"

@interface DiskCache () {
    NSString *diskCachePath;
    NSOperationQueue *cacheInQueue;
}
@end

@implementation DiskCache

static DiskCache *instance;

static NSInteger cacheMaxCacheAge = 60*60*24*7; // 1 week


#pragma mark - Singleton

+ (DiskCache *)sharedDiskCache
{
    if (instance == nil)
    {
        instance = [[DiskCache alloc] init];
    }
    
    return instance;
}

- (id)init
{
    if ((self = [super init]))
    {
        // Init the disk cache
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"InternalDiskCache"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        // Init the operation queue
        cacheInQueue = [[NSOperationQueue alloc] init];
        cacheInQueue.maxConcurrentOperationCount = 1;
        
        
        // Subscribe to app events
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    
    return self;
}

- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [diskCachePath stringByAppendingPathComponent:filename];
}

- (void)storeKeyWithDataToDisk:(NSArray *)keyAndData
{
    // Can't use defaultManager another thread
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSString *key = [keyAndData objectAtIndex:0];
    NSData *data = [keyAndData count] > 1 ? [keyAndData objectAtIndex:1] : nil;
    
    if (data)
    {
        [fileManager createFileAtPath:[self cachePathForKey:key] contents:data attributes:nil];
    }
    else
    {
        // If no data representation given, convert the UIImage in JPEG and store it
        // This trick is more CPU/memory intensive and doesn't preserve alpha channel
        UIImage *image = [self imageFromKey:key]; // be thread safe with no lock
        if (image)
        {
#if TARGET_OS_IPHONE
            if ([key rangeOfString:@".png"].location == NSNotFound){
                [fileManager createFileAtPath:[self cachePathForKey:key] contents:UIImageJPEGRepresentation(image, (CGFloat)1.0) attributes:nil];
            }else {
                [fileManager createFileAtPath:[self cachePathForKey:key] contents:UIImagePNGRepresentation(image) attributes:nil];
                
            }
#else
            NSArray*  representations  = [image representations];
            NSData* jpegData = [NSBitmapImageRep representationOfImageRepsInArray: representations usingType: NSJPEGFileType properties:nil];
            [fileManager createFileAtPath:[self cachePathForKey:key] contents:jpegData attributes:nil];
#endif
        }
    }
}


- (void)removeImageForKey:(NSString *) key
{
    if (key == nil)
    {
        return;
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:[self cachePathForKey:key] error:nil];
}


- (void)cleanDisk
{
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-cacheMaxCacheAge];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:diskCachePath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([[[attrs fileModificationDate] laterDate:expirationDate] isEqualToDate:expirationDate])
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

- (void)storeImage:(UIImage *)image imageData:(NSData *)data forKey:(NSString *)key
{
    if (!image || !key)
    {
        return;
    }
    
    if (!data) return;
    NSArray *keyWithData;
    if (data)
    {
        keyWithData = [NSArray arrayWithObjects:key, data, nil];
    }
    else
    {
        keyWithData = [NSArray arrayWithObjects:key, nil];
    }
    [cacheInQueue addOperation:[[NSInvocationOperation alloc] initWithTarget:self
                                                                    selector:@selector(storeKeyWithDataToDisk:)
                                                                      object:keyWithData]];
    
}

- (UIImage *)imageFromKey:(NSString *)key
{
    if (key == nil)
    {
        return nil;
    }
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self cachePathForKey:key]];
    
    if (image == nil){
        
    }
    
    return image;
}


@end
