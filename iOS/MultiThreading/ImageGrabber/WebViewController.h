//
//  WebViewController.h
//  ImageGrabber
//
//  Created by Ray Wenderlich on 7/3/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

//  Reference:  http://www.raywenderlich.com/4295/multithreading-and-grand-central-dispatch-on-ios-for-beginners-tutorial

#import <UIKit/UIKit.h>

@class ImageListViewController;

@interface WebViewController : UIViewController <UIWebViewDelegate> {    
    UIToolbar *toolbar;
    UIWebView *webView;
    int numLoads;
    UIBarButtonItem *grabButton;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (retain) ImageListViewController *imageListViewController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *grabButton;
- (IBAction)grabTapped:(id)sender;

@end
