//
//  AddImageToPublicationViewController.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageToPublicationViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>



//Image Layout
@property (strong, nonatomic) IBOutlet UIImageView *imgTakenPicture;
@property (strong, nonatomic) IBOutlet UIButton *btnChange;

//Buttons Layout
@property (strong, nonatomic) IBOutlet UIView *buttonContainerView;
@property (strong, nonatomic) IBOutlet UIButton *btnSelect;
@property (strong, nonatomic) IBOutlet UIButton *btnTakePicture;

//Image Data Layout
@property (strong, nonatomic) IBOutlet UIView *textFieldContainerView;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UITextField *txtFldTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtFldDescription;


- (IBAction)changePicture:(id)sender;
- (IBAction)nextStep:(id)sender;


@end
