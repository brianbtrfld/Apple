//
//  DetailViewController.m
//  ScaryBugs
//
//  Created by Brian G. Butterfield on 11/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "DetailViewController.h"
#import "ScaryBugData.h"
#import "ScaryBugImage.h"
#import "UIImageExtras.h"
#import "SVProgressHUD.h"


@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize picker = _picker;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    self.rateView.notSelectedImage = [UIImage imageNamed:@"shockedface2_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"shockedface2_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"shockedface2_full.png"];
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    if (self.detailItem)
    {
        self.titleField.text = self.detailItem.data.title;
        self.rateView.rating = self.detailItem.data.rating;
        self.imageView.image = self.detailItem.image;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setTitleField:nil];
    [self setRateView:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)titleTextChanged:(id)sender
{
    self.detailItem.data.title = self.titleField.text;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark RateViewDelegate

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating
{
    self.detailItem.data.rating = rating;
}

- (IBAction)addPictureTapped:(id)sender
{
    if (self.picker == nil)
    {
        
        // 1. show status
        [SVProgressHUD showWithStatus:@"Loading image catalog.."];
        
        // 2. get a concurrent queue from the system
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                                     0);
        // 3. load picker in background
        dispatch_async(concurrentQueue, ^
        {
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.allowsEditing = NO;
            
            // 4. present picker in main thread
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [self.navigationController presentViewController:_picker
                                                        animated:YES
                                                      completion:NULL];
                [SVProgressHUD dismiss];
            });
        });
    }
    else
    {
        [self.navigationController presentViewController:_picker animated:YES completion:NULL];
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 1. show status
    [SVProgressHUD showWithStatus:@"Resizing image.."];
    
    // 2. get a concurrent queue from the system
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                                 0);
    // 3. resize image in background
    dispatch_async(concurrentQueue, ^
    {
        UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44,44)];
                       
        // 4. present picker in main thread
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.detailItem.image = fullImage;
            self.detailItem.thumbImage = thumbImage;
            self.imageView.image = fullImage;
            [SVProgressHUD dismiss];
        });
    });
}










@end
