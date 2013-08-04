//
//  Publication.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "Publication.h"
#import "PublicationImage.h"

#define HASH_DESCRIPTION @"__description__"
#define HASH_TITLE @"__title__"
#define HASH_CONTACT_NUMBER @"__contactNumber__"
#define HASH_USERNAME @"__username__"
#define HASH_COST_PER_DAY @"__costPerDay__"
#define HASH_CARLOCATION @"__carLocation__"
#define HASH_IMG_ARRAY @"__imgArray__"
#define HASH_ARRAY_COUNT @"__imgArrayCount__"

@implementation Publication


//Methods required for saving object into disk
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        
        self.description = [decoder decodeObjectForKey:HASH_DESCRIPTION];
        self.title = [decoder decodeObjectForKey:HASH_TITLE];
        self.contactNumber = [decoder decodeObjectForKey:HASH_CONTACT_NUMBER];
        self.username = [decoder decodeObjectForKey:HASH_USERNAME];
        self.costPerDay = [decoder decodeObjectForKey:HASH_COST_PER_DAY];
        CLLocation* loc = [decoder decodeObjectForKey:HASH_CARLOCATION];
        if(loc) self.carLocation = loc.coordinate;
        self.images = [decoder decodeObjectForKey:HASH_IMG_ARRAY];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    if(self.description) [encoder encodeObject:self.description forKey:HASH_DESCRIPTION];
    if(self.title) [encoder encodeObject:self.title forKey:HASH_TITLE];
    if(self.contactNumber) [encoder encodeObject:self.contactNumber forKey:HASH_CONTACT_NUMBER];
    if(self.username) [encoder encodeObject:self.username forKey:HASH_USERNAME];
    if(self.costPerDay) [encoder encodeObject:self.costPerDay forKey:HASH_COST_PER_DAY];
    CLLocation* loc = [[CLLocation alloc] initWithLatitude:self.carLocation.latitude longitude:self.carLocation.longitude];
    if(loc) [encoder encodeObject:loc forKey:HASH_CARLOCATION];
    if(self.images) [encoder encodeObject:self.images forKey:HASH_IMG_ARRAY];
}

@end
