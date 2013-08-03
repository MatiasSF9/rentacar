//
//  PublicationImage.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublicationImage.h"

@implementation PublicationImage

#define IMG_HASH_DESCRIPTION @"__description__"
#define IMG_HASH_TITLE @"__title__"
#define IMG_HASH_LOCATION @"__imgLocation__"
#define IMG_DATA @"__imgData__"

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        
        self.description = [decoder decodeObjectForKey:IMG_HASH_DESCRIPTION];
        self.title = [decoder decodeObjectForKey:IMG_HASH_TITLE];
        CLLocation* loc = [decoder decodeObjectForKey:IMG_HASH_LOCATION];
        if(loc) self.location = loc.coordinate;
        self.imageContent = [decoder decodeObjectForKey:IMG_DATA];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    if(self.description) [encoder encodeObject:self.description forKey:IMG_HASH_DESCRIPTION];
    if(self.title) [encoder encodeObject:self.title forKey:IMG_HASH_TITLE];
    CLLocation* loc = [[CLLocation alloc] initWithLatitude:self.location.latitude longitude:self.location.longitude];
    if(loc) [encoder encodeObject:loc forKey:IMG_HASH_LOCATION];
    if(self.imageContent) [encoder encodeObject:self.imageContent forKey:IMG_DATA];
}

@end
