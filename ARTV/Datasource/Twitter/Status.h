//
//  Status.h
//  HashTV
//
//  Created by sumy on 11/08/06.
//  Copyright 2011年 Personal. All rights reserved.
//

#import "DescriptionBuilder.h"

@interface Status : NSObject {
    NSString *_statusId;
    NSDate *_createdAt;
    NSString *_fromUser;
    NSString *_fromUserId;
    NSString *_isoLanguageCode;
    //NSDictionary *_metadata;
    NSString *_profileImageUrl;
    NSString *_source;
    NSString *_text;
    NSString *_toUser;
    NSString *_toUserId;
    // NSDictionary *_geo;
}
/*
 "created_at": "Sat, 06 Aug 2011 06:36:49 +0000", 
 "from_user": "esculachonacama", 
 "from_user_id": 380200800, 
 "from_user_id_str": "380200800", 
 "geo": null, 
 "id": 99730630253875200, 
 "id_str": "99730630253875200", 
 "iso_language_code": "es", 
 "metadata": {
 "result_type": "recent"
 }, 
 "profile_image_url": "http://a0.twimg.com/profile_images/1480291414/colirio_normal.jpg", 
 "source": "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;", 
 "text": "@HuntersColirios cabei de seguir la aquele twitter", 
 "to_user": "HuntersColirios", 
 "to_user_id": 265129983, 
 "to_user_id_str": "265129983"
 */

@property (retain, readwrite) NSString *statusId;
@property (retain, readwrite) NSDate *createdAt;
@property (retain, readwrite) NSString *fromUser;
@property (retain, readwrite) NSString *fromUserId;
@property (retain, readwrite) NSString *isoLanguageCode;
//@property (retain, readwrite) NSDictionary *metadata;
@property (retain, readwrite) NSString *profileImageUrl;
@property (retain, readwrite) NSString *source;
@property (retain, readwrite) NSString *text;
@property (retain, readwrite) NSString *toUser;
@property (retain, readwrite) NSString *toUserId;
@end
