//
//  TweetSearchResult.m
//  HashTV
//
//  Created by sumy on 11/08/06.
//  Copyright 2011年 Personal. All rights reserved.
//

#import "StatusSearchResult.h"

@implementation StatusSearchResult
@synthesize completedIn = _completedIn;
@synthesize maxId = _maxId;
@synthesize nextPage = _nextPage;
@synthesize page = _page;
@synthesize query = _query;
@synthesize refreshUrl = _refreshUrl;
@synthesize results = _results;

- (NSString*)description {
    return [DescriptionBuilder reflectDescription:self];
}

- (id)initWithResults:(NSArray*)results
          completedIn:(float)completedIn
                maxId:(NSString*)maxId
             nextPage:(NSString*)nextPage
                 page:(int)page
                query:(NSString*)query
         refreshUrl:(NSString*)refreshUrl{
    [self init];
    
    self.results = results;
    self.completedIn = completedIn;
    self.maxId = maxId;
    self.nextPage = nextPage;
    self.page = page;
    self.query = query;
    self.refreshUrl = refreshUrl;
    return self;
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
    [_maxId release];
    [_nextPage release];
    [_query release];
    [_refreshUrl release];
    [_results release];
    
    [super dealloc];
}
@end
