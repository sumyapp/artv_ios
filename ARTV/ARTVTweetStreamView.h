//
//  ARTVTweetStreamView.h
//  ARTV
//
//  Created by sumy on 11/08/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

/*
 簡単な取説:
 1. 取得したツイートをx=480から一定速度でxマイナス方向に表示させる
 2. 高さは10段階、基本は一番上、かぶる物がある場合のみ次段以降。1巡した場合には上から再スタート
 3. 長いツイートは早く、短いツイートは早く進行させる(6秒でxを480から0まで。平均)
 4. 初回取得ツイートは破棄、以降は取得分から表示していく…？
 5. ツイートはUIViewのAnimationで処理しちゃおうかな
 */

#import <UIKit/UIKit.h>
#import "ARTVChannel.h"
#import "StatusSearchResult.h"
#import "Twitter.h"
#define CACHE_STATUS_COUNT_MAX 60
#define GET_STATUS_COUNT_IN_ONE_REQUEST 50
#define STATUS_AUTO_RELOAD_TIME 5.0f
#define MAX_ROW_COUNT 8

@interface ARTVTweetStreamView : UIView {
    // ツイートコンテンツ
    BOOL _isFirstCache;
    BOOL _isFirstGetSearchResultThisChannel;
    ARTVChannel *_currentChannel;
    NSMutableArray *_tweetsCacheArray; // UILabel生成時にはツイートは取り除く
    NSString *_latestTweetId;
    
    // ツイートのUILabelのリスト
    NSMutableArray *_tweetLabelsArray;
    
    // ツイートの自動リロード
    NSTimer *_tweetReloadTimer;
    BOOL _reloading;
}
- (void)tweetStreamStart;
- (void)setChannel:(ARTVChannel*)channnel;
- (void)drawTweetLabels:(NSString*)tweet;
- (void)tweetMoveToLeftAnimationDidStop;
- (void)popupConnetionLostError;
@end