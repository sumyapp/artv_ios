//
//  ARTVChannelSelectView.h
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTVChannels.h"
#import "ARTVChannelButton.h"
#define CHANNEL_BUTTON_WIDTH 55
#define CHANNEL_BUTTON_HEIGHT 46
#define CHANNEL_BUTTON_MARGIN 1

@protocol ARTVChannelSelectViewDelegate;

@interface ARTVChannelSelectView : UIView {
    NSArray *_channels;
    ARTVChannel *_selectedChannel;
    NSMutableArray *_channelButtons;
    id delegate;
}
- (void)channelButtonTouchUpInside:(ARTVChannelButton*)button;
- (void)setSelectedChannelThisAppPrevLaunch;
@property (assign, readwrite) id delegate;
@end

@protocol ARTVChannelSelectViewDelegate <NSObject>
- (void)channelSelected:(ARTVChannel*)channel;
@end