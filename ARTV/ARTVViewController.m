//
//  ARTVViewController.m
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVViewController.h"

@implementation ARTVViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    LOG_METHOD
//    [self cameraViewApper];  
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(cameraViewApper) userInfo:nil repeats:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    LOG_METHOD
    if(_cameraOverlayView) {
        [_cameraOverlayView removeFromSuperview];
        [_cameraOverlayView release];
        _cameraOverlayView = nil;
    }
    
    if(_pickerController) {
        [_pickerController dismissModalViewControllerAnimated:NO];
        [_pickerController release];
        _pickerController = nil;
    }
}

- (void)cameraViewApper {
    LOG_METHOD
    // カメラが使用可能かどうかチェックする
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        LOG(@"isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera");
        // イメージピッカーを作る
        _pickerController = [[ARTVImagePickerController alloc] init];
        [_pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [_pickerController setShowsCameraControls:NO];
        [_pickerController setAllowsEditing:NO];
        [_pickerController setWantsFullScreenLayout:YES];
        [_pickerController setNavigationBarHidden:YES];
        
        // カメラオーバーレイビューをインスタンス化
        _cameraOverlayView = [[ARTVCameraOverlayView alloc] initWithFrame:CGRectMake(0, 0, 480, 480)];
        _cameraOverlayView.transform = CGAffineTransformMakeRotation(M_PI/2);
        [_cameraOverlayView setFrame:CGRectMake(0, 0, 320, 480)];
        
        // カメラオーバーレイビューを追加する
        _pickerController.cameraOverlayView = _cameraOverlayView;
        [_cameraOverlayView tweetStreamStart];
        
        // イメージピッカーを表示する
        [self presentModalViewController:_pickerController animated:NO];
    }
}

- (void)imagePickerControllerViewDidApper:(id)imagePickerController {
    LOG_METHOD
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
