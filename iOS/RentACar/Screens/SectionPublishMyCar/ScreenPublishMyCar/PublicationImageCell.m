//
//  PublicationImageCell.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublicationImageCell.h"

@interface PublicationImageCell() {
    IBOutlet UIImageView* image;
    IBOutlet UILabel* title;
}

@end

@implementation PublicationImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Cleans the style while selectin the cell.
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void) configureCell:(PublicationImage*) publicationImage {
    //Configures the cell whith the publication image data.
    [image setImage:[UIImage imageWithData:[publicationImage imageContent]]];
    [title setText:[publicationImage title]];
}

@end
