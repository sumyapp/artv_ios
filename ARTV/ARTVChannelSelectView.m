//
//  ARTVChannelSelectView.m
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVChannelSelectView.h"

@implementation ARTVChannelSelectView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    LOG_METHOD
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _channels = [ARTVChannels channels];
        LOG(@"_channels = %@", [_channels description]);
        int i = 0;
        _channelButtons = [[NSMutableArray alloc] init];
        for (ARTVChannel *channel in _channels) {
            ARTVChannelButton *button = [[ARTVChannelButton alloc] initWithFrame:CGRectMake(0, i*CHANNEL_BUTTON_HEIGHT-CHANNEL_BUTTON_MARGIN, CHANNEL_BUTTON_WIDTH, CHANNEL_BUTTON_HEIGHT)];
            [button setChannel:channel];
            [button setTitle:channel.channelName1Character forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"UITabBarItemBackground.png"] forState:UIControlStateNormal];
            //[button setBackgroundImage:[UIImage imageNamed:@"UITabBarItemBackgroundSelected_5.png"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"UITabBarItemBackgroundSelected.png"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(channelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_channelButtons addObject:button];
            [button release];
            i++;
        }
    }
    return self;
}

- (void)channelButtonTouchUpInside:(ARTVChannelButton*)button {
    LOG_METHOD
    for (ARTVChannelButton *otherButton in _channelButtons) {
        [otherButton setSelected:NO];
    }
    [button setSelected:YES];    
    [delegate channelSelected:button.channel];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:button.channel.channelName forKey:@"SELECTED_CHANNEL_NAME"];
    [defaults synchronize];
}

- (void)setSelectedChannelThisAppPrevLaunch {
    LOG_METHOD
    // 前回使用していたチャンネルを開く
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *selectedChannelName = [defaults objectForKey:@"SELECTED_CHANNEL_NAME"];
    if(selectedChannelName) {
        for (ARTVChannelButton *button in _channelButtons) {
            if([button.channel.channelName isEqualToString:selectedChannelName]) {
                [self channelButtonTouchUpInside:button];
                break;
            }
        }
    }
    else {
        [self channelButtonTouchUpInside:[_channelButtons objectAtIndex:0]];
    }
}

- (void)setChannelRatingData:(NSDictionary*)ratingData {
    LOG(@"setChannelRatingData:ratingData = %@", [ratingData description]);
    for (ARTVChannelButton *button in _channelButtons) {
        int rate = [[ratingData objectForKey:button.channel.channelName] intValue];
        LOG(@"channel[%@] = %d", [button.channel channelName], rate);
        
        NSMutableString *fileName = [[[NSMutableString alloc] init] autorelease];
        NSMutableString *fileNameSelected = [[[NSMutableString alloc] init] autorelease];
        
        [fileName appendFormat:@"UITabBarItemBackground"];
        [fileNameSelected appendFormat:@"UITabBarItemBackgroundSelected"];
        
        if(rate > 0 && rate <= 5) {
            [fileName appendFormat:@"_%d.png", rate];
            [fileNameSelected appendFormat:@"_%d.png", rate];
        }
        else {
            [fileName appendFormat:@"png"];
            [fileNameSelected appendFormat:@"png"];
        }
        
        [button setBackgroundImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:fileNameSelected] forState:UIControlStateSelected];
        
    }
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
