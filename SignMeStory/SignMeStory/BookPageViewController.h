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

//static NSString *X_Percentage = @"X_Percentage";
//static NSString *Y_Percentage = @"Y_Percentage";

@protocol ProcessAfterGettingWishlist <NSObject>

@required
//@param aBool : Yes = success, No = fail
//@param bookArray the array of the books
- (void) isRetrievingSuccessful : (BOOL) aBool bookArray: (NSArray*) array ;
- (void) retrieve:(int) currentPosition;
@end

@interface BookPageViewController : UIViewController<AVAudioPlayerDelegate,UITextViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate> {
    SignMeStoryFS *storyFS;
    NSString *pagePath;
    bool audion;
    bool *lastpage;
    bool *withSound;
    float durationOfAudio;
}

@property (nonatomic) UIButton *nextPButton;
@property (nonatomic) UILabel *pageTextLabel;
@property (nonatomic) UIImageView * backgroundImageView;
@property (nonatomic) UIImageView * textBackgroundView;
@property (nonatomic) UIImage *backgroundImage;
@property (nonatomic) UITextView *textView;
@property (nonatomic) UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *animationImage;
@property (nonatomic, strong) NSMutableArray *listOfText;
@property (nonatomic, strong) NSMutableArray *listOfAudio;
@property (nonatomic, strong) NSString *pageText;
@property (nonatomic, strong) UITapGestureRecognizer *singeTap;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property int positionOfText;
@property (nonatomic) NSString *pagePath;



@property (nonatomic, strong) NSMutableArray *backgroundImages;
- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andPagePath: (NSString *) path andWithSound: (bool)hasSound;



@end
