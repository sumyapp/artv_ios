//
//  ARTVCameraOverlayView.m
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVCameraOverlayView.h"

@implementation ARTVCameraOverlayView

#pragma mark - ARTVChannelSelectViewDelegate
- (void)channelSelected:(ARTVChannel*)channel {
    LOG_METHOD
    [_tweetStreamView setChannel:channel];
    [_tweetSendView setSuffixText:[channel.hashTags objectAtIndex:0]];
    [_tweetSendView.textField setText:[NSString stringWithFormat:@" %@ #HashTV", _tweetSendView.suffixText]];
}

- (void)channelRatingDataDidChange:(NSDictionary*)ratingData {
    LOG_METHOD
    [_channelSelectView setChannelRatingData:ratingData];
}

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tweetStreamView = [[ARTVTweetStreamView alloc] initWithFrame:CGRectMake(0, TWEET_SEND_VIEW_HEIGHT, TWEET_STREAM_VIEW_WIDTH, TWEET_STREAM_VIEW_HEIGHT)];
        [_tweetStreamView setDelegate:self];
        [_tweetStreamView setUserInteractionEnabled:NO];
        [self addSubview:_tweetStreamView];

        _tweetSendView = [[ARTVTweetSendView alloc] initWithFrame:CGRectMake(0, 0, TWEET_SEND_VIEW_WIDTH, TWEET_SEND_VIEW_HEIGHT)];
        [self addSubview:_tweetSendView];

        _channelSelectView = [[ARTVChannelSelectView alloc] initWithFrame:CGRectMake(WIDTH - CHANNEL_SELECT_VIEW_WIDTH, 0, CHANNEL_SELECT_VIEW_WIDTH, CHANNEL_SELECT_VIEW_HEIGHT)];
        [_channelSelectView setDelegate:self];
        [self addSubview:_channelSelectView];        
    }
    return self;
}

- (void)tweetStreamStart {
    LOG_METHOD
    [_tweetStreamView tweetStreamStart];
    [_channelSelectView setSelectedChannelThisAppPrevLaunch];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_tweetSendView setKeyboardHidden:YES];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
