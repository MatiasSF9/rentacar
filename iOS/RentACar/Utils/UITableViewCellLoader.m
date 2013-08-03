//
//  UITableViewCellLoader.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "UITableViewCellLoader.h"

@implementation UITableViewCell (loadCellNib)

+ (id) loadCellNibForTableView:(UITableView*)tableView withIdentifier:(NSString*)cellNibName  {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNibName];
	
    if (cell == nil){
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:cellNibName owner:nil options:nil];
        for (id currentObject in nibObjects){
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (UITableViewCell*)currentObject;
                if (![cell.reuseIdentifier isEqualToString:cellNibName]){
					NSLog(@"Cell (%@) identifier does not match its nib name", cellNibName);
				}
                break;
            }
        }
    }
	
	if ( !cell ) {
		NSLog(@"Unable to load cell from nib: %@", cellNibName);
	}
	
	return cell;
}

@end
