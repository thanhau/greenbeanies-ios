//
//  BookPageViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SignMeStoryFS.h"

static NSString *X_Percentage = @"X_Percentage";
static NSString *Y_Percentage = @"Y_Percentage";


@interface BookPageViewController : UIViewController<AVAudioPlayerDelegate,UITextViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate> {
    SignMeStoryFS *storyFS;
    NSString *pagePath;
    bool audion;
    bool *lastpage;
    bool *withSound;
}

@property (nonatomic, retain) UILabel *pageTextLabel;
@property (nonatomic, retain) UIImageView * backgroundImageView;
//@property (nonatomic, retain) UIImageView *textBackground;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, strong, retain) NSMutableArray *animationImage;
@property (nonatomic, strong, retain) NSMutableArray *listOfText;
@property (nonatomic, strong, retain) NSMutableArray *listOfAudio;
@property (nonatomic, strong, retain) NSString *pageText;
@property (nonatomic, strong, retain) UITapGestureRecognizer *singeTap;
@property (strong, nonatomic, retain) UIToolbar *toolBar;
@property (strong, nonatomic, retain) UIButton *leftButton;
@property (strong, nonatomic, retain) UIButton *rightButton;
@property int positionOfText;
@property (nonatomic, retain) NSString *pagePath;



@property (nonatomic, strong) NSMutableArray *backgroundImages;

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andPagePath: (NSString *) path;
- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andPagePath: (NSString *) path andWithSound: (bool)hasSound;



@end
