//
//  AddImageToPublicationViewController.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageToPublicationViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btnTakePicture;
@property (strong, nonatomic) IBOutlet UIImageView *imgTakenPicture;

@end
