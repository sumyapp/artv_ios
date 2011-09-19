//
//  HTVHashTags.h
//  HashTV
//
//  Created by sumy on 11/08/07.
//  Copyright 2011年 Personal. All rights reserved.
//
#import "ARTVChannel.h"


@interface ARTVChannels : NSObject
+ (ARTVChannel*)channelByHashTag:(NSString*)hashTag;
+ (ARTVChannel*)channelByChannelName:(NSString*)channelName;
+ (NSArray*)channels;
@end
