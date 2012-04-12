//
//  ARTVTweetSendView.h
//  ARTV
//
//  Created by sumy on 11/09/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SEND_BUTTON_WIDTH 50
#define TEXT_FIELD_MARGIN_X 5
#define TEXT_FIELD_MARGIN_Y 5

@interface ARTVTweetSendView : UIView<UITextFieldDelegate> {
    UIButton *_sendButton;
    UITextField *_textField;
    UIImageView *_backgroundImageView;
    NSString *_suffixText;
}
- (void)tweetSend:(id)sender;
- (void)setKeyboardHidden:(BOOL)hidden;
@property (retain, readwrite) NSString *suffixText;
@property (nonatomic, readonly) UITextField *textField;
@end
