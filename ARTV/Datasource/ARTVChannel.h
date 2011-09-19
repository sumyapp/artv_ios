//
//  HTVHashTag.h
//  HashTV
//
//  Created by sumy on 11/08/07.
//  Copyright 2011年 Personal. All rights reserved.
//



@interface ARTVChannel : NSObject {
    NSArray *_hashTags;
    NSString *_channelName;
    NSString *_channelName1Character;
    NSString *_category;
}
@property (retain, readwrite) NSArray *hashTags;
@property (retain, readwrite) NSString *channelName;
@property (retain, readwrite) NSString *channelName1Character;
@property (retain, readwrite) NSString *category;
@end
