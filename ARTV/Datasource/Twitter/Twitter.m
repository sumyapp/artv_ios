//
//  Tweets.m
//  HashTV
//
//  Created by sumy on 11/08/06.
//  Copyright 2011年 Personal. All rights reserved.
//

#import "Twitter.h"

@implementation Twitter

+ (NSDate*)dateFromCreatedAtDateString:(NSString*)strDate {
	NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSArray *tokens = [strDate componentsSeparatedByCharactersInSet:charSet];
    
	NSString *month = [NSMutableString stringWithString:[tokens objectAtIndex:2]];
	int monthInt;
	NSArray *monthStrData =  [[[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",
                               @"Jul", @"Aug",@"Sep", @"Oct", @"Nov",@"Dec", nil] autorelease];
	for (int i=0; i<11; i++) {
		if([month isEqualToString:[monthStrData objectAtIndex:i]]){
			monthInt = i+1;
			break;
		}
	}
    
	NSDateFormatter *inputDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[inputDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
	[inputDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	NSString *intputDateStr = [NSString stringWithFormat:@"%@/%d/%@ %@", [tokens objectAtIndex:3], monthInt, [tokens objectAtIndex:1], [tokens objectAtIndex:4]];
    
	return [inputDateFormatter dateFromString:intputDateStr];
}

+ (StatusSearchResult*)getSearchResultsForQuery:(NSString*)query {
    LOG(@"Twitter getSearchResultsForQuery:%@", (NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) [NSString stringWithFormat:@"%@?lang=%@&%@&", TWITTER_SEARCH_API_URL, TWITTER_SEARCH_LANG, query], NULL, NULL, kCFStringEncodingUTF8));
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) [NSString stringWithFormat:@"%@?%@", TWITTER_SEARCH_API_URL, query], NULL, NULL, kCFStringEncodingUTF8)] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSDictionary *jsonDic = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
    
    StatusSearchResult *statusSearchResult = [[[StatusSearchResult alloc] init] autorelease];
    for (id key in jsonDic) {
        if([@"completed_in" isEqualToString:key]) {
            [statusSearchResult setCompletedIn:[[jsonDic objectForKey:key] floatValue]];
        }
        else if([@"max_id_str" isEqualToString:key]) {
            [statusSearchResult setMaxId:[jsonDic objectForKey:key]];
        }
        else if([@"next_page" isEqualToString:key]) {
            [statusSearchResult setNextPage:[jsonDic objectForKey:key]];
        }
        else if([@"page" isEqualToString:key]) {
            [statusSearchResult setPage:[[jsonDic objectForKey:key] intValue]];
        }
        else if([@"query" isEqualToString:key]) {
            [statusSearchResult setQuery:[jsonDic objectForKey:key]];
        }
        else if([@"refresh_url" isEqualToString:key]) {
            [statusSearchResult setRefreshUrl:[jsonDic objectForKey:key]];
        }
        else if([@"results" isEqualToString:key]) {
            NSMutableArray *results = [[NSMutableArray alloc] init];
            NSArray *resultsArray = [jsonDic objectForKey:key];
            for (NSDictionary *tweetDic in resultsArray) {
                Status *status = [[Status alloc] init];
                for (id tweetKey in tweetDic) {
                    if([tweetDic objectForKey:tweetKey] == [NSNull null] || [tweetDic objectForKey:tweetKey] == nil) {
                    }
                    else if([@"created_at" isEqualToString:tweetKey]) {
                        [status setCreatedAt:[self dateFromCreatedAtDateString:[tweetDic objectForKey:tweetKey]]];
                    }
                    else if([@"from_user" isEqualToString:tweetKey]) {
                        [status setFromUser:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"from_user_id_str" isEqualToString:tweetKey]) {
                        [status setFromUserId:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"id_str" isEqualToString:tweetKey]) {
                        [status setStatusId:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"iso_language_code" isEqualToString:tweetKey]) {
                        [status setIsoLanguageCode:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"profile_image_url" isEqualToString:tweetKey]) {
                        [status setProfileImageUrl:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"source" isEqualToString:tweetKey]) {
                        [status setSource:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"text" isEqualToString:tweetKey]) {
                        [status setText:[tweetDic objectForKey:tweetKey]];
                    }
                    else if([@"to_user_id_str" isEqualToString:tweetKey]) {
                        [status setToUserId:[tweetDic objectForKey:tweetKey]];
                    }
                }
                [results addObject:status];
            }
            [statusSearchResult setResults:results];
        }
    }
    
    return statusSearchResult;
}

+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords {
    if(keywords == nil || [keywords count] < 1) {
        return nil;
    }
    
    if ([keywords count] <= 1) {
        return [self getSearchResultsForQuery:[NSString stringWithFormat:@"q=%@", [keywords objectAtIndex:0]]];
    }
    
    NSString *query = [[[NSString alloc] initWithFormat:@"q=%@", [keywords objectAtIndex:0]] autorelease];
    for (int i = 1; i < [keywords count]; i++) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"+OR+%@", [keywords objectAtIndex:i]]];
    }
    
    return [self getSearchResultsForQuery:query];
}

+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords
                                           sinceId:(NSString*)sinceId
                                    startingAtPage:(int)pageNum
                                             count:(int)count {
    if(keywords == nil || [keywords count] < 1) {
        return nil;
    }
    
    if ([keywords count] <= 1) {
        return [self getSearchResultsForQuery:[NSString stringWithFormat:@"q=%@&page=%d&rpp=%d&since_id=%@", [keywords objectAtIndex:0],  pageNum, count, sinceId]];
    }
    
    NSString *query = [[[NSString alloc] initWithFormat:@"q=%@", [keywords objectAtIndex:0]] autorelease];
    for (int i = 1; i < [keywords count]; i++) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"+OR+%@", [keywords objectAtIndex:i]]];
    }
    
    return [self getSearchResultsForQuery:[NSString stringWithFormat:@"%@&page=%d&rpp=%d&since_id=%@", query,  pageNum, count, sinceId]];
}

+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords
                                             maxId:(NSString*)maxId
                                    startingAtPage:(int)pageNum
                                             count:(int)count {
    if(keywords == nil || [keywords count] < 1) {
        return nil;
    }
    
    if ([keywords count] <= 1) {
        return [self getSearchResultsForQuery:[NSString stringWithFormat:@"q=%@&page=%d&rpp=%d&max_id=%@", [keywords objectAtIndex:0],  pageNum, count, maxId]];
    }
    
    NSString *query = [[[NSString alloc] initWithFormat:@"q=%@", [keywords objectAtIndex:0]] autorelease];
    for (int i = 1; i < [keywords count]; i++) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"+OR+%@", [keywords objectAtIndex:i]]];
    }
    
    return [self getSearchResultsForQuery:[NSString stringWithFormat:@"%@&page=%d&rpp=%d&max_id=%@", query,  pageNum, count, maxId]];
}

+ (StatusSearchResult*)getSearchResultsForKeywords:(NSArray*)keywords
                                    startingAtPage:(int)pageNum
                                             count:(int)count {
    if(keywords == nil || [keywords count] < 1) {
        return nil;
    }
    
    if ([keywords count] <= 1) {
        return [self getSearchResultsForQuery:[NSString stringWithFormat:@"q=%@&page=%d&rpp=%d", [keywords objectAtIndex:0],  pageNum, count]];
    }
    
    NSString *query = [[[NSString alloc] initWithFormat:@"q=%@", [keywords objectAtIndex:0]] autorelease];
    for (int i = 1; i < [keywords count]; i++) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"+OR+%@", [keywords objectAtIndex:i]]];
    }
    
    return [self getSearchResultsForQuery:[NSString stringWithFormat:@"%@&page=%d&rpp=%d", query,  pageNum, count]];}


+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword {
    if(keyword == nil) {
        return nil;
    }
    
    return [self getSearchResultsForQuery:[NSString stringWithFormat:@"q=%@", keyword]];
}

+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword
                               sinceId:(NSString*)sinceId
                        startingAtPage:(int)pageNum
                                 count:(int)count {
    if(keyword == nil) {
        return nil;
    }
    
    return [self getSearchResultsForKeyword:[NSArray arrayWithObjects:keyword, nil]];
}

+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword
                                 maxId:(NSString*)maxId
                        startingAtPage:(int)pageNum
                                 count:(int)count {
    if(keyword == nil) {
        return nil;
    }
    
    return [self getSearchResultsForKeywords:[NSArray arrayWithObjects:keyword, nil] maxId:maxId startingAtPage:pageNum count:count];
}

+ (StatusSearchResult*)getSearchResultsForKeyword:(NSString*)keyword
                                   startingAtPage:(int)pageNum
                                            count:(int)count {
    if(keyword == nil) {
        return nil;
    }
    
    return [self getSearchResultsForKeywords:[NSArray arrayWithObjects:keyword, nil] startingAtPage:pageNum count:count];
}
@end
