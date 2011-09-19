//
//  ARTVTweetStreamView.m
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVTweetStreamView.h"

@implementation ARTVTweetStreamView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)tweetStreamStart {
    LOG_METHOD
    if(_tweetReloadTimer) {
        [_tweetReloadTimer invalidate];
        _tweetReloadTimer = nil;
    }
    _tweetReloadTimer = [NSTimer scheduledTimerWithTimeInterval:STATUS_AUTO_RELOAD_TIME
                                                         target:self
                                                       selector:@selector(autoReloadStatusSearchRelust:)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void)setChannel:(ARTVChannel*)channnel {
    LOG_METHOD
    if(_currentChannel != nil) {
        [_currentChannel release];
        _currentChannel = nil;
    }
    
    _currentChannel = channnel;
    [channnel retain];
    
    _isFirstCache = YES;
    _isFirstGetSearchResultThisChannel = YES;
}

#pragma mark - UIGenerate
- (void)drawTweetLabels:(NSString*)tweet {
    LOG_METHOD
    
    // 追加したLabelの管理用
    if(!_tweetLabelsArray) {
        _tweetLabelsArray = [[NSMutableArray alloc] init];
    }
        
    // 最大の表示領域CGSize。このCGSize以上は文字列長がこのサイズを超える場合はすべて表示されない
    float fontSize = 22;
    CGSize bounds = CGSizeMake(4000, self.frame.size.height);
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [tweet sizeWithFont:font constrainedToSize:bounds lineBreakMode:UILineBreakModeTailTruncation];    
    
    // 文字列の表示位置を決定する
    int xpos = 480;
    int width = size.width;
    int height = size.height;
    float timeDuration = 4.0;
    // MAX_ROWの中に収める
    int row = [_tweetLabelsArray count];
    while (row >= MAX_ROW_COUNT) {
        row -= MAX_ROW_COUNT;
        xpos += 1000; //1画面からはみ出る場合、幾らかを遅く(右側)にする
        timeDuration += 2.0; //1画面からはみ出る場合、幾らかを遅く(右側)にする
    }
    
    int timeDurationAddTmp = width;
    while (timeDurationAddTmp > 500) {
        timeDuration += 1.0; // 長いやつが早過ぎるので、調整用
        timeDurationAddTmp -= 500;
    }
    
    // yの最大始点を求める(5はなんとなくマージン)
    int yposMax = self.frame.size.height - 5 - size.height;
    LOG(@"yposMax = %d", yposMax);
    
    int ypos = row * yposMax/MAX_ROW_COUNT;
    
//    int ypos = (size.height + 5) * [_tweetLabelsArray count];

//    while (ypos+size.height > 320) {
//        ypos -= 320;
//    }
    
    UILabel *label = [[[UILabel alloc] init] autorelease];
    [label setText:tweet];
    [label setFrame:CGRectMake(xpos, ypos, width, height)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:fontSize]];
    [label setTextColor:[UIColor whiteColor]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:label];
    [_tweetLabelsArray addObject:label];    

    // Labelが左側に向かうアニメーションを生成、開始
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //[UIView beginAnimations:nil context:context];
    [UIView beginAnimations:nil context:label];
    [UIView setAnimationDuration:timeDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(tweetMoveToLeftAnimationDidStop:finished:context:)];
    
    //TODO: 
    [label setFrame:CGRectMake(0-width, ypos, width, height)];
    
    // アニメーション開始
    [UIView commitAnimations];
    LOG(@"STATUS[%d] = x,y,widh,height=%d,%d,%d,%d", [_tweetLabelsArray count]-1, 0-(width+200), ypos, width, height);
}

- (void)tweetMoveToLeftAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context { 
    LOG_METHOD
    // ツイートのUILabelを画面から取り除く
//    if(_tweetLabelsArray == nil || [_tweetLabelsArray isEqual:[NSNull class]]||[_tweetLabelsArray count] <= 0) {
//        return;
//    }
    UILabel *label = (UILabel*)context;
    [label removeFromSuperview];
    [_tweetLabelsArray removeObject:label];
} 


#pragma mark - ReloadStatus
- (void)autoReloadStatusSearchRelust:(NSTimer*)timer {
    LOG_METHOD
    if(!_reloading && _currentChannel != nil) {
        [NSThread detachNewThreadSelector:@selector(reloadStatusSearchResult)
                                 toTarget:self withObject:nil];
    }
}


- (void)reloadStatusSearchResultDidEnd {
    LOG_METHOD
    // ツイートをLabel化、Arrayから削除
    if(_isFirstCache && [_tweetsCacheArray count] > 0) {
        [_tweetsCacheArray removeAllObjects];
        _isFirstCache = NO;
    }
    
    for (Status *status in _tweetsCacheArray) {
        [self drawTweetLabels:status.text];
    }
    [_tweetsCacheArray removeAllObjects];
}

- (void)reloadStatusSearchResult {
    LOG_METHOD
    NSAutoreleasePool* pool;
    pool = [[NSAutoreleasePool alloc]init];
    
    // _currentChannelがない状態で来た場合はそのまま終了
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if(_currentChannel == nil || [_currentChannel isKindOfClass:[NSNull class]]) {
        LOG(@"ERROR: _currentChannel == nil");
        [self performSelectorOnMainThread:@selector(doneLoadingTableViewData)
                               withObject:nil
                            waitUntilDone:YES];
        
        [pool release];
        [NSThread exit];
        return;
    }
    
    StatusSearchResult *statusSearchResult;
    // そのチャンネルの初回ロード時
    if(_isFirstGetSearchResultThisChannel) {
        statusSearchResult = [Twitter getSearchResultsForKeywords:_currentChannel.hashTags startingAtPage:1 count:GET_STATUS_COUNT_IN_ONE_REQUEST];
    }
    // 2回目以降のロード時
    else {
         statusSearchResult = [Twitter getSearchResultsForKeywords:_currentChannel.hashTags sinceId:_latestTweetId startingAtPage:1 count:GET_STATUS_COUNT_IN_ONE_REQUEST];
    }
    
    // ツイート取得成功時
    if(statusSearchResult.maxId != nil) {
        _isFirstGetSearchResultThisChannel = NO;
        _latestTweetId = [[NSString alloc] initWithString:statusSearchResult.maxId];
    }
    // ツイート取得失敗時(ネットワークエラー)
    else {
        LOG(@"getSearchResultsForKeywords request is failed");
        [self performSelectorOnMainThread:@selector(popupConnetionLostError)
                               withObject:nil
                            waitUntilDone:YES];
    }
    
    // そのチャンネルの初回ロード時
    if(!_tweetsCacheArray) {
        _tweetsCacheArray = [[NSMutableArray alloc] init];
    }
    // 取得済みツイート数がCACHE_TWEETS_COUNT_MAXを超えたとき
    if(CACHE_STATUS_COUNT_MAX < [statusSearchResult.results count] + [_tweetsCacheArray count]) {
        int deleteCount = [_tweetsCacheArray count] + [statusSearchResult.results count] - CACHE_STATUS_COUNT_MAX;
        int deleteStartPos = [_tweetsCacheArray count] - deleteCount - 1;
        
        LOG(@"get %d new tweets, current have %d tweet.So, remove tweets in NSMakeRange(%d,%d)", [statusSearchResult.results count], [_tweetsCacheArray count], deleteStartPos, deleteCount);
        [_tweetsCacheArray removeObjectsInRange:NSMakeRange(deleteStartPos, deleteCount)];
    }
    
    NSArray *arr = statusSearchResult.results;
    for(int i = [arr count]; i > 0; i--) {
        [_tweetsCacheArray insertObject:[arr objectAtIndex:i-1] atIndex:0];
    }
    LOG(@"get %d new tweets, total %d tweet", [arr count], [_tweetsCacheArray count]);
    
    [self performSelectorOnMainThread:@selector(reloadStatusSearchResultDidEnd)
						   withObject:nil
						waitUntilDone:YES];
	
	[pool release];
    [NSThread exit];
}

- (void)popupConnetionLostError {
    LOG_METHOD
}

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isFirstCache = YES;
        _isFirstGetSearchResultThisChannel = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
