//
//  PublishMyCarViewController.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "PublishMyCarViewController.h"
#import "PublicationPreviewViewController.h"
#import "AddImageToPublicationViewController.h"
#import "PublicationBuilder.h"
#import "PublicationImageCell.h"

#define HEIGHT_CELL_CAR_IMAGES_PUBLICATION  50
#define MAX_TABLE_HEIGHT                    150

//Private interface and properties
@interface PublishMyCarViewController () {
    IBOutlet UITextField* txtUsername;
    IBOutlet UITextField* txtContactNumber;
    IBOutlet UITextField* txtTitle;
    IBOutlet UITextField* txtDescription;
    IBOutlet UITextField* txtRentalCost;
    IBOutlet UITableView* tblCarImages;
    IBOutlet UIScrollView* dataScrollView;
}

@end

@implementation PublishMyCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Rent My Car", @"Rent My Car");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    //Resizes the view content when is going to be shown to do it properly.
    [self resizeContent];
}

- (void) resizeContent {
    
    //Adjust atumatically the list size, but prevents it from increasing more than 3 rows. From there, it scrolls
    int futureHeight = [[[PublicationBuilder sharedInstance] getCurrentPublicationImages] count] * HEIGHT_CELL_CAR_IMAGES_PUBLICATION;
    
    [tblCarImages setFrame:CGRectMake(tblCarImages.frame.origin.x,
                                     tblCarImages.frame.origin.y,
                                     tblCarImages.frame.size.width,
                                     futureHeight > MAX_TABLE_HEIGHT ? MAX_TABLE_HEIGHT : futureHeight)];
    
    //Make the scroll view have a content size equal to last point of the last element so everything can be seen while scrolling.
    [dataScrollView setContentSize:CGSizeMake(dataScrollView.frame.size.width, tblCarImages.frame.origin.y + tblCarImages.frame.size.height)];
}

#pragma Mark - IBActions

- (IBAction) openPreview:(id)sender {
    [self.navigationController pushViewController:[[PublicationPreviewViewController alloc] initWithNibName:@"PublicationPreviewViewController" bundle:nil]
                                         animated:YES];
}

- (IBAction) addPicture:(id)sender {
    [self.navigationController pushViewController:[[AddImageToPublicationViewController alloc] initWithNibName:@"AddImageToPublicationViewController" bundle:nil]
                                         animated:YES];
}

#pragma mark - UITextFieldDelegate delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if([textField isEqual:txtContactNumber]) {
       [[PublicationBuilder sharedInstance] setPublicationContactNumber:textField.text];
    } else if([textField isEqual:txtDescription]) {
       [[PublicationBuilder sharedInstance] setPublicationDescription:textField.text];
    } else if([textField isEqual:txtRentalCost]) {
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [[PublicationBuilder sharedInstance] setPublicationCostPerDay: [formatter numberFromString:textField.text]];
    } else if([textField isEqual:txtTitle]) {
        [[PublicationBuilder sharedInstance] setPublicationTitle:textField.text];
    } else if([textField isEqual:txtUsername]) {
        [[PublicationBuilder sharedInstance] setPublicationUsername:textField.text];
    }
}

#pragma mark - UITableViewDataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self resizeContent];
    return [[[PublicationBuilder sharedInstance] getCurrentPublicationImages] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Deques exisiting cells to reuse them and avoid using too much memory for cell displaying. This is a critical point beacuse we are handling heavy images on each cell.
    PublicationImageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID-PublicationImageCell"];
    
    //Only if no cell was available to reuse, create a new one.
    if(!cell) {
        cell = [[PublicationImageCell alloc] init];
    }
    
    //Configure the cell with the data to display.
    [cell configureCell:[[[PublicationBuilder sharedInstance] getCurrentPublicationImages] objectAtIndex:indexPath.row]];
     
     return cell;
}

#pragma mark - UITableViewDelegate delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: Do something with row selection.
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_CELL_CAR_IMAGES_PUBLICATION;
}

@end
