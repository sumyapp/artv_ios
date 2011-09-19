//
//  HTVHashTags.m
//  HashTV
//
//  Created by sumy on 11/08/07.
//  Copyright 2011年 Personal. All rights reserved.
//

#import "ARTVChannels.h"

@implementation ARTVChannels

+ (ARTVChannel*)channelByHashTag:(NSString*)hashTag {
    NSArray *channels = [self channels];
    for (ARTVChannel* channel in channels) {
        for (NSString *tag in channel.hashTags) {
            if([hashTag isEqualToString:tag]) {
                return channel;
            }
        }
    }
    return nil;
}

+ (ARTVChannel*)channelByChannelName:(NSString*)channelName {
    NSArray *channels = [self channels];
    for (ARTVChannel* channel in channels) {
        if([channel.channelName isEqualToString:channelName]) {
            return channel;
        }
    }
    return nil;
}

+ (NSArray*)channels {
    NSMutableArray *channels = [[[NSMutableArray alloc] init] autorelease];
    NSString *categoryTV = @"テレビ";
    ARTVChannel *channel1 = [[[ARTVChannel alloc] init] autorelease];
    [channel1 setHashTags:[NSArray arrayWithObjects:@"#nhk", nil]];
    [channel1 setChannelName1Character:@"1"];
    [channel1 setChannelName:@"NHK総合"];
    [channel1 setCategory:categoryTV];
    [channels addObject:channel1];
    
    ARTVChannel *channel2 = [[[ARTVChannel alloc] init] autorelease];
    [channel2 setHashTags:[NSArray arrayWithObjects:@"#etv",@"#nhk2", nil]];
    [channel2 setChannelName1Character:@"2"];
    [channel2 setChannelName:@"NHK教育"];
    [channel2 setCategory:categoryTV];
    [channels addObject:channel2];
    
    ARTVChannel *channel4 = [[[ARTVChannel alloc] init] autorelease];
    [channel4 setHashTags:[NSArray arrayWithObjects:@"#ntv", @"#tvnihon", @"#日テレ", @"#日本テレビ", nil]];
    [channel4 setChannelName1Character:@"4"];
    [channel4 setChannelName:@"日本テレビ"];
    [channel4 setCategory:categoryTV];
    [channels addObject:channel4];
    
    ARTVChannel *channel5 = [[[ARTVChannel alloc] init] autorelease];
    [channel5 setHashTags:[NSArray arrayWithObjects:@"#tvasahi", @"#テレビ朝日", nil]];
    [channel5 setChannelName1Character:@"5"];
    [channel5 setChannelName:@"テレビ朝日"];
    [channel5 setCategory:categoryTV];
    [channels addObject:channel5];
    
    ARTVChannel *channel6 = [[[ARTVChannel alloc] init] autorelease];
    [channel6 setHashTags:[NSArray arrayWithObjects:@"#tbs", nil]];
    [channel6 setChannelName1Character:@"6"];
    [channel6 setChannelName:@"TBSテレビ"];
    [channel6 setCategory:categoryTV];
    [channels addObject:channel6];
    
    ARTVChannel *channel7 = [[[ARTVChannel alloc] init] autorelease];
    [channel7 setHashTags:[NSArray arrayWithObjects:@"#tvtokyo", @"#テレビ東京", nil]];
    [channel7 setChannelName1Character:@"7"];
    [channel7 setChannelName:@"テレビ東京"];
    [channel7 setCategory:categoryTV];
    [channels addObject:channel7];
    
    ARTVChannel *channel8 = [[[ARTVChannel alloc] init] autorelease];
    [channel8 setHashTags:[NSArray arrayWithObjects:@"#fujitv", @"#フジテレビ", nil]];
    [channel8 setChannelName1Character:@"8"];
    [channel8 setChannelName:@"フジテレビ"];
    [channel8 setCategory:categoryTV];
    [channels addObject:channel8];

    return channels;
}

@end
