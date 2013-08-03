//
//  UITableViewCellLoader.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewCell (loadCellNib)
/**
 * Reuses the cell if exists, otherwise creates a new instance inflating a xib with the name passed in the parameter.
 */
+ (id) loadCellNibForTableView:(UITableView*)tableView withIdentifier:(NSString*)cellNibName;
@end
