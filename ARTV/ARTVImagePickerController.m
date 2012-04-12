//
//  ARTVImagePickerController.m
//  ARTV
//
//  Created by sumy on 11/08/23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVImagePickerController.h"
#import <Twitter/Twitter.h>

#define HORIZ_SWIPE_MIN 12
#define VERT_SWIPE_MAX 8
#define SWIPE_NON 0
#define SWIPE_LEFT 1
#define SWIPE_RIGHT 2

@implementation ARTVImagePickerController
CGPoint startPt;
int swipe_direction;
float zoomScale = 1.0;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_METHOD
    startPt = [[touches anyObject] locationInView:self.view];	
    swipe_direction = SWIPE_NON;
    LOG(@"x座標:%f y座標:%f",startPt.x,startPt.y);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_METHOD
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_METHOD
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_METHOD
    CGPoint curPt = [[touches anyObject] locationInView:self.view];	
    // 水平のスワイプを検出
    if(fabsf(startPt.y - curPt.y) >= HORIZ_SWIPE_MIN && fabsf(startPt.x - curPt.x) <= VERT_SWIPE_MAX){
        if(startPt.y > curPt.y){
            swipe_direction = SWIPE_LEFT;
            LOG(@"SWIPE_LEFT");
            zoomScale -= 0.1;
            if(zoomScale < 1.0) {
                zoomScale = 1.0;
            }
            self.cameraViewTransform = CGAffineTransformMakeScale(zoomScale, zoomScale);
        }else{
            swipe_direction = SWIPE_RIGHT;
            LOG(@"SWIPE_RIGHT");
            zoomScale += 0.1;
            if(zoomScale > 10.0) {
                zoomScale = 10.0;
            }
            self.cameraViewTransform = CGAffineTransformMakeScale(zoomScale, zoomScale);
        }
    }
    LOG(@"x座標:%f y座標:%f",curPt.x,curPt.y);
}

- (void)launchTwitterIOS5:(NSNotification*)notification {
    LOG_METHOD
    
    if (!TWTweetComposeViewController.canSendTweet) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                       message:NSLocalizedString(@"cantsendtweet", nil)
                                                      delegate:nil
                                             cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *value = [[notification userInfo] objectForKey:@"TWEET_TEXT"];
    TWTweetComposeViewController *twitterCtl = [[TWTweetComposeViewController alloc] init];
    [twitterCtl setInitialText:value];
    twitterCtl.completionHandler = ^(TWTweetComposeViewControllerResult result)  {
        [self dismissModalViewControllerAnimated:YES];
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                break;
                
            case TWTweetComposeViewControllerResultDone:
                break;
                
            default:
                break;
        }
    };
    [self presentModalViewController:twitterCtl animated:YES];  
}

- (void)viewDidLoad {
    LOG_METHOD
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(launchTwitterIOS5:) name:@"LAUNCH_TWITTER_IOS5" object:nil];
}

@end
