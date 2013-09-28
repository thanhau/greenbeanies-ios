//
//  TestViewController.h
//  SignMeStory
//
//  Created by Thanh Au on 9/5/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SignMeStoryFS.h"
static NSString *X_Percentage = @"X_Percentage";
static NSString *Y_Percentage = @"Y_Percentage";
@interface TestViewController : UIViewController<AVAudioPlayerDelegate,UITextViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    SignMeStoryFS *storyFS;
    NSString *pagePath;
    bool audion;
    bool *lastpage;
    bool *withSound;
    float durationOfAudio;
    int nPages;
    
    int currentPageOfDirectory;
    float originalZoomScale;
    float newZoomScale;
    CGSize originalRectVisible;
    CGSize newRectVisible;
    
}
@property (nonatomic) UIButton *nextPButton;
@property (nonatomic) UILabel *pageTextLabel;
@property (nonatomic) UIImageView * backgroundImageView;
@property (nonatomic) UIImageView * textBackgroundView;
@property (nonatomic) UIScrollView * scrollView;
@property (nonatomic) UIImage *backgroundImage;
@property (nonatomic) UITextView *textView;
@property (nonatomic) UIWebView *webView;
//@property (nonatomic, strong) NSMutableArray *animationImage;
@property (nonatomic, strong) NSMutableArray *listOfText;
@property (nonatomic, strong) NSMutableArray *listOfAudio;
@property (nonatomic, strong) NSString *pageText;
@property (nonatomic, strong) UITapGestureRecognizer *singeTap;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *homeButton;
@property int positionOfText;
@property (nonatomic) NSString *pagePath;
@property (nonatomic, strong) NSMutableArray *listOfAllBackgroundImageView;
@property (nonatomic, strong) NSMutableArray *listOfAllText;
@property (nonatomic, strong) NSMutableArray *listOfAllAudio;
@property (nonatomic, strong) NSMutableArray *listOfAllZoomSpec;
//Array of dictionary  of zoom spec
@property (nonatomic, strong) NSMutableArray *listOfZoomSpec;

//@property (nonatomic, strong) NSMutableDictionary *dictOfZoomSpec;

@property (nonatomic, retain) NSString *bookTitle;
@property (nonatomic, strong) NSMutableArray *pageTextArray;
@property (nonatomic, retain) NSString *bookPath;

@property (nonatomic, strong) NSMutableArray *pageNumber;





@property (nonatomic, strong) NSMutableArray *backgroundImages;


- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle andWithSound: (bool)hasSound;

@end
