//
//  ARTChannelButton.h
//  ARTV
//
//  Created by sumy on 11/08/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVChannel.h"

@interface ARTVChannelButton : UIButton {
    ARTVChannel *_channel;
}
@property (retain, readwrite) ARTVChannel *channel;
@end
