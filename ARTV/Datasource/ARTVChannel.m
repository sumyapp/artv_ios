//
//  HTVHashTag.m
//  HashTV
//
//  Created by sumy on 11/08/07.
//  Copyright 2011年 Personal. All rights reserved.
//

#import "ARTVChannel.h"
#import "DescriptionBuilder.h"

@implementation ARTVChannel
@synthesize hashTags = _hashTags;
@synthesize channelName = _channelName;
@synthesize channelName1Character = _channelName1Character;
@synthesize category = _category;

- (NSString*)description {
    return [DescriptionBuilder reflectDescription:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [_hashTags release];
    [_channelName release];
    [_channelName1Character release];
    [_category release];
    
    [super dealloc];
}

@end
