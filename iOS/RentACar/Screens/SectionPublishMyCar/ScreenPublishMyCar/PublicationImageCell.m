//
//  PublicationImageCell.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublicationImageCell.h"

@interface PublicationImageCell() {
    IBOutlet UIImageView* publicationThumbnail;
    IBOutlet UILabel* title;
    IBOutlet UILabel* description;
}

@end

@implementation PublicationImageCell


- (void) configureCell:(PublicationImage*) publicationImage {
    
    //Cleans the style while selectin the cell.
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //Configures the cell whith the publication image data.
    [publicationThumbnail setImage:[UIImage imageWithData:[publicationImage imageContent]]];
    [title setText:[publicationImage title]];
    [description setText:[publicationImage description]];
}

@end
