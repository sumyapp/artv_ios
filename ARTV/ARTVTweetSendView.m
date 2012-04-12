//
//  ARTVTweetSendView.m
//  ARTV
//
//  Created by sumy on 11/09/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ARTVTweetSendView.h"

@implementation ARTVTweetSendView
@synthesize suffixText = _suffixText;
@synthesize textField = _textField;

- (id)initWithFrame:(CGRect)frame
{
    LOG_METHOD
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.8];
        
        // Initialization code
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_backgroundImageView];

        _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - SEND_BUTTON_WIDTH, 0, SEND_BUTTON_WIDTH, frame.size.height)];
        [_sendButton setBackgroundColor:[UIColor whiteColor]];
        [_sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(tweetSend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(TEXT_FIELD_MARGIN_X, TEXT_FIELD_MARGIN_Y, frame.size.width - SEND_BUTTON_WIDTH - TEXT_FIELD_MARGIN_X*2, frame.size.height - TEXT_FIELD_MARGIN_X*2)];
        [_textField setBackgroundColor:[UIColor darkGrayColor]];
        [_textField setTextColor:[UIColor whiteColor]];
        [_textField setDelegate:self];
        [_textField setReturnKeyType:UIReturnKeySend];
        [self addSubview:_textField];
        
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//     [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    LOG_METHOD
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
     [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)setKeyboardHidden:(BOOL)hidden {
    LOG_METHOD
    if(hidden) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight
                                                          animated:NO];
        [_textField resignFirstResponder];
    }
}

- (void)tweetSend:(id)sender {
    LOG_METHOD
    [self setKeyboardHidden:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_sendButton release], _sendButton = nil;
    [_textField release], _textField = nil;
    [_backgroundImageView release], _backgroundImageView = nil;
    [_suffixText release], _suffixText = nil;
    
    [super dealloc];
}

@end
