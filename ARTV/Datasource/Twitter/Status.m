//
//  Status.m
//  HashTV
//
//  Created by sumy on 11/08/06.
//  Copyright 2011年 Personal. All rights reserved.
//

#import "Status.h"

@implementation Status
@synthesize statusId = _statusId;
@synthesize createdAt = _createdAt;
@synthesize fromUser = _fromUser;
@synthesize fromUserId = _fromUserId;
@synthesize isoLanguageCode = _isoLanguageCode;
//@synthesize metadata = _metadata;
@synthesize profileImageUrl = _profileImageUrl;
@synthesize source = _source;
@synthesize text = _text;
@synthesize toUser = _toUser;
@synthesize toUserId = _toUserId;

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
    [_statusId release];
    [_createdAt release];
    [_fromUser release];
    [_fromUserId release];
    [_isoLanguageCode release];
//    [_metadata release];
    [_profileImageUrl release];
    [_source release];
    [_text release];
    [_toUser release];
    [_toUserId release];
    
    [super dealloc];
}
@end
