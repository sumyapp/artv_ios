//
//  ARTVCameraOverlayView.h
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTVChannel.h"
#import "ARTVTweetStreamView.h"
#import "ARTVChannelSelectView.h"
#import "ARTVTweetSendView.h"
#define WIDTH 480
#define HEIGHT 320
#define CHANNEL_SELECT_VIEW_WIDTH 55
#define CHANNEL_SELECT_VIEW_HEIGHT HEIGHT
#define TWEET_SEND_VIEW_WIDTH (WIDTH - CHANNEL_SELECT_VIEW_WIDTH)
#define TWEET_SEND_VIEW_HEIGHT 35
#define TWEET_STREAM_VIEW_WIDTH (WIDTH-CHANNEL_SELECT_VIEW_WIDTH)
#define TWEET_STREAM_VIEW_HEIGHT (HEIGHT - TWEET_SEND_VIEW_HEIGHT)

@interface ARTVCameraOverlayView : UIView<ARTVTweetStreamViewDelegate,ARTVChannelSelectViewDelegate> {
    // チャンネルボタン
    ARTVChannelSelectView *_channelSelectView;
    
    // ツイートストリーム
    ARTVTweetStreamView *_tweetStreamView;
    
    // ツイート入力部分
    ARTVTweetSendView *_tweetSendView;
    
    // 接続エラー表示(UIAlertView不可)
    BOOL _isConnectionLostPopupPresented;
    
    // 投稿用View
}
- (void)tweetStreamStart;
@end
