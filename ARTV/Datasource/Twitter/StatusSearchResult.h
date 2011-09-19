//
//  TweetSearchResult.h
//  HashTV
//
//  Created by sumy on 11/08/06.
//  Copyright 2011年 Personal. All rights reserved.
//
#import "DescriptionBuilder.h"

@interface StatusSearchResult : NSObject {
    float _completedIn;
    NSString *_maxId;
    NSString *_nextPage;
    int _page;
    NSString *_query;
    NSString *_refreshUrl;;
    NSArray *_results; // statusが入っている
}
- (id)initWithResults:(NSArray*)results
          completedIn:(float)completedIn
                maxId:(NSString*)maxId
             nextPage:(NSString*)nextPage
                 page:(int)page
                query:(NSString*)query
           refreshUrl:(NSString*)refreshUrl;
@property (readwrite) float completedIn;
@property (retain, readwrite) NSString *maxId;
@property (retain, readwrite) NSString *nextPage;
@property (readwrite) int page;
@property (retain, readwrite) NSString *query;
@property (retain, readwrite) NSString *refreshUrl;
@property (retain, readwrite) NSArray *results;
@end
