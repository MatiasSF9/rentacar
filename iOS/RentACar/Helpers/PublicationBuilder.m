//
//  PublicationBuilder.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublicationBuilder.h"
#import "Publication.h"
#import "PublicationImage.h"

#define PUBLICATION_KEY     @"-0-Publication-0-"

@interface PublicationBuilder ()

@property (nonatomic, retain) NSMutableArray* imagesList;

@property (nonatomic, retain) Publication* currentPublication;
@property (nonatomic, assign) id<PublicationBuildStatusDelegate> delegate;

@end

static PublicationBuilder* instance;

@implementation PublicationBuilder

#pragma mark - Singleton

+ (PublicationBuilder*) sharedInstance {
    if(!instance) {
        instance = [[PublicationBuilder alloc] createInstance];
    }
    
    return instance;
}

- (id) init {
    @throw @"This Class works as a singleton. Please use the [PublicationBuilder sharedInstance] instead";
}

- (PublicationBuilder*) createInstance {
    PublicationBuilder* this = [super init];
    [this startNewPublication];
    return this;
}

- (void) clearCurrentBuild {
    [self startNewPublication];
}


#pragma mark - Initializing Methods

- (void) startNewPublication {
    self.currentPublication = [[Publication alloc] init];
    self.imagesList = [[NSMutableArray alloc] init];
}

#pragma mark - Publication Handling

- (void) buildReportingStatusToDelegate:(id<PublicationBuildStatusDelegate>) delegate {
    self.delegate = delegate;
    
    for (int i = 0; i < self.imagesList.count; i++) {
        PublicationImage* img = [self.imagesList objectAtIndex:i];
        //TODO: Perform HTTP POST request to upload each of the images. (1 request per image)
        [delegate updateStatus:[NSNumber numberWithFloat:((i+1)/self.imagesList.count) * 100]];
    }
    
    [delegate didEndPublishing];
    
    [self.currentPublication setImages:self.imagesList];
}

#pragma mark - Publication Handling

//Setters
- (void) setPublicationDescription:(NSString*) description {
    [self.currentPublication setDescription:description];
};
- (void) setPublicationTitle:(NSString*) title {
    [self.currentPublication setTitle:title];
}
- (void) setPublicationContactNumber:(NSString*) contactNumber {
    [self.currentPublication setContactNumber:contactNumber];
}
- (void) setPublicationUsername:(NSString*) username {
    [self.currentPublication setUsername:username];
}
- (void) setPublicationCostPerDay:(NSNumber*) costPerDay {
    [self.currentPublication setCostPerDay:costPerDay];
}
- (void) setCurrentCarLocation:(CLLocationCoordinate2D) location {
    [self.currentPublication setCarLocation:location];
};


//Getters
- (NSString*) getPublicationDescription {
    return  [self.currentPublication description];
};
- (NSString*) getPublicationTitle {
    return [self.currentPublication title];
}
- (NSString*) getPublicationContactNumber {
    return [self.currentPublication contactNumber];
}
- (NSString*) getPublicationUsername {
    return [self.currentPublication username];
}
- (NSNumber*) getPublicationCostPerDay {
    return  [self.currentPublication costPerDay];
}
- (CLLocationCoordinate2D) getCurrentCarLocation {
    return [self.currentPublication carLocation];
};

#pragma mark - PublicationImages Handling
- (BOOL) addImageToPublicationWithTitle:(NSString*) title
                            description:(NSString*) description
                             inLocation:(CLLocationCoordinate2D) location
                       withImageRawData:(NSData*) data {
    
    //There is no image, wich is a mandatory field, so return informing that no image has been added.
    if(!data) return NO;
    
    PublicationImage* image = [[PublicationImage alloc] init];
    [image setTitle:title];
    [image setDescription:description];
    [image setLocation:location];
    [image setImageContent:data];

    [self.imagesList addObject:image];
    
    return YES;
}

- (NSArray*) getCurrentPublicationImages {
    return self.imagesList;
}

#pragma mark - PersistentStorage

+ (void) saveInstanceOnPersistentStorage {
    //Makes sure the singleton is created
    [PublicationBuilder sharedInstance];
    
    [instance.currentPublication setImages:instance.imagesList];
    //Archives the object after deleting the previous one
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: PUBLICATION_KEY];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:instance.currentPublication]
                                              forKey: PUBLICATION_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) restoreInstanceFromPersistentStorage {
    
    //Makes sure the singleton is created
    [PublicationBuilder sharedInstance];
    
    //Retrieves and decompress the Archieved object
    id object  = [[NSUserDefaults standardUserDefaults] objectForKey: PUBLICATION_KEY];
    
	if (object) {
		instance.currentPublication = [NSKeyedUnarchiver unarchiveObjectWithData:object];
        instance.imagesList = instance.currentPublication.images;
	}
	else {
        [instance startNewPublication];
	}
}



@end
