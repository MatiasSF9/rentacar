dasd//
//  AddImageToPublicationViewController.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "AddImageToPublicationViewController.h"
#import "KeyboardManager.h"
#import "PublicationBuilder.h"

@interface AddImageToPublicationViewController ()

@end

@implementation AddImageToPublicationViewController

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add New Photo", @"Add New Photo");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtFldDescription.delegate = self;
    self.txtFldTitle.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)takePicture:(UIButton *)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [[[UIAlertView alloc] initWithTitle:@""message:@"This device does not support camera pictures" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }

    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = (sender == self.btnTakePicture) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentModalViewController:picker animated:YES];
    
}

- (IBAction)selectLibraryPicture:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing photo library" message:@"Device does not support a photo library" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)changePicture:(id)sender {
    self.imgTakenPicture.image = nil;
    [self switchLayoutsVisibility: YES];
}

- (IBAction)nextStep:(id)sender {
    NSData *imageData = UIImagePNGRepresentation(self.imgTakenPicture.image);
    [[PublicationBuilder sharedInstance] addImageToPublicationWithTitle:self.txtFldTitle.text
                                                            description:self.txtFldDescription.text
                                                             inLocation:self.location
                                                       withImageRawData:imageData];
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)locateCarInMap:(id)sender {
    LocatInMapViewController* controller = [[LocatInMapViewController alloc] initWithNibName:@"LocatInMapViewController" bundle:nil];
    [controller setTapDelegate:self];
    
    //If location is valid, show it on the map
    if(CLLocationCoordinate2DIsValid(self.location)) {
        [controller showPins:[[NSMutableArray alloc] initWithObjects:[[CLLocation alloc] initWithLatitude:self.location.latitude longitude:self.location.longitude], nil]];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    
    [self resizeImageAndPreview: image];

    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self didCompleteAllFields];
    [KeyboardManager returnToViewFrame: self.textFieldContainerView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual: self.txtFldTitle]) {
        [self.txtFldDescription becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [KeyboardManager willMoveToVisibleArea:textField inView: self.textFieldContainerView];
}

#pragma mark - TapCoordinatesDelegate

- (void)mapWasTappedinLocation:(CLLocationCoordinate2D) coordinates{
    self.location = coordinates;
    self.lblLocation.text = [NSString stringWithFormat:@"%0.4f, %0.4f",
                                coordinates.latitude, coordinates.longitude];
    self.lblLocation.hidden = NO;
    [self didCompleteAllFields];
}

#pragma mark - Private Methods

- (void)resizeImageAndPreview: (UIImage*) image {
    
    self.imgTakenPicture.image = [self.imgTakenPicture makeResizedImage: image :self.imgTakenPicture.frame.size quality:kCGInterpolationMedium];
    [self switchLayoutsVisibility: NO];
}

- (void)switchLayoutsVisibility:(BOOL)visibility {
    self.textFieldContainerView.hidden = visibility;
    self.buttonContainerView.hidden = !visibility;
}

- (void)didCompleteAllFields {
    self.btnNext.hidden =  [self.txtFldTitle.text isEqualToString:@""]
                        || [self.txtFldDescription.text isEqualToString:@""]
                        || !self.imgTakenPicture.image
                        || self.location.latitude == 0;
}

@end
