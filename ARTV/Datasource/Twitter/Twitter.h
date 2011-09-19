//
//  Tweets.h
//  HashTV
//
//  Created by sumy on 11/08/06.
//  Copyright 2011年 Personal. All rights reserved.
//
#import "CJSONDeserializer.h"
#import "StatusSearchResult.h"
#import "Status.h"
#define TWITTER_SEARCH_API_URL @"http://search.twitter.com/search.json"
#define TWITTER_SEARCH_LANG @"ja"

@interface Twitter : NSObject
+ (StatusSearchResult*)getSearchResultsForQuery:(NSString*)query;

+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords;
+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords
                                           sinceId:(NSString*)sinceId
                                    startingAtPage:(int)pageNum
                                             count:(int)count;
+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords
                                             maxId:(NSString*)maxId
                                    startingAtPage:(int)pageNum
                                             count:(int)count;
+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords
                                    startingAtPage:(int)pageNum
                                             count:(int)count;


+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword;
+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword
                                 sinceId:(NSString*)sinceId
                          startingAtPage:(int)pageNum
                                   count:(int)count;
+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword
                                   maxId:(NSString*)maxId
                          startingAtPage:(int)pageNum
                                   count:(int)count;
+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword
                                   startingAtPage:(int)pageNum
                                            count:(int)count;
@end
