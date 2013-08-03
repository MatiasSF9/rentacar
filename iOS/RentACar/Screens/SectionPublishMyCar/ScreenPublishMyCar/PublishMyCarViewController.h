//
//  PublishMyCarViewController.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishMyCarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    IBOutlet UITextField* txtUsername;
    IBOutlet UITextField* txtContactNumber;
    IBOutlet UITextField* txtTitle;
    IBOutlet UITextField* txtDescription;
    IBOutlet UITextField* txtRentalCost;
    IBOutlet UITableView* tblCarImages;
}

@end
