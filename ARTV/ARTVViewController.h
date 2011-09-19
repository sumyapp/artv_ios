//
//  ARTVViewController.h
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTVCameraOverlayView.h"
#import "ARTVChannelSelectView.h"
#import "ARTVImagePickerController.h"

@interface ARTVViewController : UIViewController {
    ARTVImagePickerController *_pickerController;
    ARTVCameraOverlayView *_cameraOverlayView;
}
@end