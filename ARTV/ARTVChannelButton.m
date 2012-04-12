//
//  ARTChannelButton.m
//  ARTV
//
//  Created by sumy on 11/08/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVChannelButton.h"

@implementation ARTVChannelButton
@synthesize channel = _channel;

- (void)setChannelRating:(int)rating {
    LOG_METHOD
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
    [_channel release];
    [super dealloc];
}
@end
