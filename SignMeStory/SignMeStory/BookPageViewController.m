//
//  BookPageViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "BookPageViewController.h"

@interface BookPageViewController ()
{
    AVAudioPlayer *theAudio;
    MPMoviePlayerController *mpc;
    
}
@end

@implementation BookPageViewController
@synthesize pagePath;
@synthesize pageText;
@synthesize backgroundImageView;
@synthesize backgroundImage;
@synthesize textView;
@synthesize animationImage;
@synthesize webView;
@synthesize positionOfText;
@synthesize listOfAudio;
@synthesize backgroundImages;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(playAnimation)
                                   userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
}

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andPagePath: (NSString *) path {
    self = [super init];
    if (self) {
        storyFS = aStoryFS;
        
        // init backgroundImages
        [self setBackgroundImages: [storyFS getPageBackgrounds:path]];
        [self setListOfText: [storyFS getListOfText:path]];
 
        // init background animation and chat bubble
        [self initBackgroundAnimation];
        [self initChatBublle];
        if (self.listOfAudio != nil)
        {
            
        }
    
        //adding arrow
        [self addLeftButton];
        [self addRightButton];
        
        // adding toolbar at bottom
        [self addToolBar];
        
        //[self addPlayVideoButton];
        
        //hide arrow if only have one item in array
        if ([self.listOfText count] == 1)
        {
            self.leftButton.hidden = YES;
            self.rightButton.hidden = YES;
        }
        
        //[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
    }
    return self;
}

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andPagePath: (NSString *) path andWithSound: (bool)hasSound{
    self = [super init];
    if (self) {
        storyFS = aStoryFS;
        
        // init backgroundImages
        [self setBackgroundImages: [storyFS getPageBackgrounds:path]];
        [self setListOfText: [storyFS getListOfText:path]];
        
        // init background animation and chat bubble
        [self initBackgroundAnimation];
        [self initChatBublle];
        if (self.listOfAudio != nil)
        {
            
        }
        
        //adding arrow
        [self addLeftButton];
        [self addRightButton];
        
        // adding toolbar at bottom
        [self addToolBar];
        
        //[self addPlayVideoButton];
        
        //hide arrow if only have one item in array
        if ([self.listOfText count] == 1)
        {
            self.leftButton.hidden = YES;
            self.rightButton.hidden = YES;
        }
        
        //[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
    }
    return self;
}


- (void) initBackgroundAnimation {
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.backgroundImageView setImage: [[self backgroundImages ]objectAtIndex:0]];
    
    if (self.backgroundImages != nil) {
        self.backgroundImageView.animationImages = self.backgroundImages;
        self.backgroundImageView.animationDuration = 1;
        self.backgroundImageView.animationRepeatCount = 1;
    }
    [self.view addSubview:self.backgroundImageView];
}

- (void) initChatBublle {
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(self.backgroundImageView.frame.origin.x, self.backgroundImageView.frame.origin.y, 400, 60)];
    //[self addHighlighToTextWithVideo];
    NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:0]];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    self.webView.opaque = NO;
    [self.webView setDelegate:self];
    
    UIImage *imgChatBubble = [storyFS getChatBubbleImg];
    UIImageView *textBackgroundView = [[UIImageView alloc]init];
    [textBackgroundView setFrame: CGRectMake(40, 0, self.webView.frame.size.width, self.webView.frame.size.height)];
    [textBackgroundView setImage:[self imageWithImage:imgChatBubble convertToSize:self.webView.frame.size]];

    [textBackgroundView addSubview:self.webView];
    [self.backgroundImageView addSubview:textBackgroundView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * @function animation
 * @abstract animation 
 * @discussion It creates animation from group of imgage 
 */
-(void) playAnimation{
    self.backgroundImageView.image = [[self backgroundImages ] lastObject];
    [self.backgroundImageView startAnimating];
}

/*!
 * @function addLeftButton
 * @abstract adding an left button in the view so user can go back to previous text
 * @discussion It creates button that let user go back to previous text
 */
- (void) addLeftButton {
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(5, self.backgroundImageView.frame.size.height/2, 50, 50)];
    
    
    UIImage *leftArrow = [storyFS getLeftButtonImg];
    
    [self.leftButton setImage:leftArrow forState:UIControlStateNormal];
    
    
    [self.leftButton addTarget:self action:@selector(goToPreviousText) forControlEvents:UIControlEventTouchUpInside];
    self.singeTap.cancelsTouchesInView = NO;
    self.leftButton.hidden = YES;
    [self.view addSubview: self.leftButton];
}


/*!
 * @function addRightButton
 * @abstract adding an right button in the view so user can go back to previous text
 * @discussion It creates button that let user go back to previous text
 */
- (void) addRightButton {
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.height - 50, self.backgroundImageView.frame.size.height/2, 50, 50)];
    UIImage *rightArrow = [storyFS getRightButtonImg];
    
    [self.rightButton setImage:rightArrow forState:UIControlStateNormal];
    
    [self.rightButton addTarget:self action:@selector(goToNextText) forControlEvents:UIControlEventTouchUpInside];
    self.singeTap.cancelsTouchesInView = NO;
    [self.view addSubview: self.rightButton];
}


/*!
 * @function goToNextText
 * @abstract go to next text when user click on right button
 * @discussion It go to next text when user click on right button
 */
-(void)goToNextText {
    self.positionOfText = self.positionOfText + 1;
   
    if (self.positionOfText < [self.listOfText count])
    {
       
        
        if (self.leftButton.hidden == YES)
        {
            self.leftButton.hidden = NO;
        }
        if (self.positionOfText == [self.listOfText count] - 1)
        {
            self.rightButton.hidden = YES;
        }
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
    
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
        CGFloat width = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.width"] floatValue];
        CGRect frame = self.webView.frame;
        frame.size.height = height;
        frame.size.width = width;
        self.webView.frame = frame;
        CGRect textBackgroundFrame = CGRectMake(40, 0, frame.size.width, frame.size.height);
        self.textBackground.frame = textBackgroundFrame;

    }
    else
    {
        self.rightButton.hidden = YES;
    }
}

/*!
 * @function goToPreviousText
 * @abstract go to previous text when user click on left button
 * @discussion It go to previous text when user click on left button
 */
-(void)goToPreviousText {
    self.positionOfText = self.positionOfText - 1;
    
    if (self.positionOfText >= 0)
    {
        if (self.rightButton.hidden == YES)
        {
            self.rightButton.hidden = NO;
        }
        if (self.positionOfText == 0)
        {
            self.leftButton.hidden = YES;
        }
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
        
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        
        
        CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
        CGFloat width = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.width"] floatValue];
        CGRect frame = self.webView.frame;
        frame.size.height = height;
        frame.size.width = width;
        self.webView.frame = frame;
        CGRect textBackgroundFrame = CGRectMake(40, 0, frame.size.width, frame.size.height);
        self.textBackground.frame = textBackgroundFrame;
    }
    else
    {
        self.leftButton.hidden = YES;
    }
}


- (void) addPlayVideoButton {
    UIImage *playImage = [UIImage imageNamed:@"play.png"];
    UIButton *playVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
    
    
    
    [playVideoButton setImage:playImage forState:UIControlStateNormal];
    
    [playVideoButton addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: playVideoButton];
    
}
/*!
 * @function playVideo
 * @abstract play video
 * @discussion It play certain video
 */
-(void) playVideo
{
    NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:@"hat" ofType:@"mp4"];
    NSURL *urlVideo = [NSURL fileURLWithPath:stringVideoPath];
    mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
    [mpc setMovieSourceType:MPMovieSourceTypeFile];
    [[self view]addSubview:mpc.view];
    [mpc setFullscreen:YES];
    [mpc play];
}

/*!
 * @function addPauseButton
 * @abstract adding an pause audio button in the view so user can pause the audio
 * @discussion It creates button that pause audio
 */
- (void) addPauseButton {
    UIImage *pauseImage = [UIImage imageNamed:@"pause.png"];
    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 2 + 35, self.backgroundImageView.frame.size.height - 45, 30, 30)];

    [pauseButton setImage:pauseImage forState:UIControlStateNormal];
    
    [pauseButton addTarget:self action:@selector(pauseAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: pauseButton];
    
}

/*!
 * @function pauseAudio
 * @abstract pause audio for text
 * @discussion pause audio for text
 */
-(void)pauseAudio {
    
    [theAudio pause];
    NSLog(@"pause");
        
    
    
}
/*!
 * @function addPlayButton
 * @abstract adding an play audio button in the view so user can play the audio
 * @discussion It creates button that play audio
 */
- (void) addPlayButton {
    UIImage *playImage = [UIImage imageNamed:@"play.png"];
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 2, self.backgroundImageView.frame.size.height - 45, 30, 30)];
    
    
    
    [playButton setImage:playImage forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: playButton];
    
}

/*!
 * @function resize the image
 * @abstract resize the image
 * @discussion resize the image
 */
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
/*!
 * @function playAudio
 * @abstract play audio for text
 * @discussion play audio for text
 */
-(void)playAudio
{
    [theAudio play];
    NSLog(@"play");
}



/*!
 * @function addPlayButton
 * @abstract adding an play audio button in the view so user can play the audio
 * @discussion It creates button that play audio
 */
- (void) addStopButton {
    
    UIImage *stopImage = [UIImage imageNamed:@"stop.png"];
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 2 - 35, self.backgroundImageView.frame.size.height - 45, 30, 30)];
    
    [stopButton setImage:stopImage forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: stopButton];
    
}

/*!
 * @function playAudio
 * @abstract play audio for text
 * @discussion play audio for text
 */
-(void)stopAudio
{
    [theAudio stop];
    NSLog(@"stop");
}
/*!
 * @function showToolBar
 * @abstract show or hide the tool bar
 * @discussion show or hide the tool bar when user click on it
 */
- (void)showToolbar
{
    NSLog(@"tap");
    if (self.toolBar.hidden == YES) {
        [UIView animateWithDuration:1
                         animations:^(void) {
                             [self.toolBar setAlpha:1];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = NO;
                             [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
                         }
        ];
                //[self.view bringSubviewToFront:self.toolBar];
        
    }
    else if (self.toolBar.hidden == NO) {
        
        [UIView animateWithDuration:1
                         animations:^(void) {
                             [self.toolBar setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = YES;
                         }
         ];
        
    }
}

/*!
 * @function auto hide toolbar
 * @abstract auto hide toolbar for control the audio
 * @discussion It hide toolbar automaticly 
 */
-(void) autoHideToolBar
{
    if (self.toolBar.hidden == NO) {
        
        [UIView animateWithDuration:1
                         animations:^(void) {
                             [self.toolBar setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = YES;
                         }
         ];
        
    }

}

/*!
 * @function create toolbar
 * @abstract create toolbar for control the audio
 * @discussion It creates toolbar that use can play, stop, pause the audio
 */
-(void) addToolBar
{
    // add tool bar
    self.toolBar = [[UIToolbar alloc] init];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.width - 44, self.view.frame.size.height, 44); // need to change the width according to orientation
    // make toolbar transparent
    [self.toolBar setBarStyle:UIBarStyleBlack];
    self.toolBar.translucent = YES;
    // init the singe tap gesture
    self.singeTap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showToolbar)];
    
    self.singeTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singeTap];
    self.view.userInteractionEnabled = YES;
    //Canlce interference on click baritembutton
    self.singeTap.cancelsTouchesInView = NO;
    [self.singeTap setDelegate:self];
    [self.view addSubview:self.toolBar];
    //create space to aligment the toolbar item
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //create play button
    UIBarButtonItem *playButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
     target:self
     action:@selector(playAudio)];
    
    //create pause button
    UIBarButtonItem *pauseButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemPause
     target: self
     action:@selector(pauseAudio)];
    
    //create bar button
    UIBarButtonItem *stopButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemStop
     target: self
     action:@selector(stopAudio)];
    
    //create quit button
    
    UIImage *quitIconImg = [storyFS getQuitImg];
    UIBarButtonItem *quitButton = [[UIBarButtonItem alloc] initWithImage:quitIconImg style:UIBarButtonItemStylePlain target:self action:@selector(quit)];
    NSArray *buttons = [[NSArray alloc]
                        initWithObjects:quitButton,flexibleSpace,playButton, pauseButton,stopButton,flexibleSpace, nil];
    
    self.toolBar.items = buttons;
    
    
}


/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    // Don't recognize taps in the buttons
    return ((! [self.leftButton pointInside:[touch locationInView:self.leftButton] withEvent:nil]) &&
            (! [self.rightButton pointInside:[touch locationInView:self.rightButton] withEvent:nil]));
}
/*!
 * @function webViewDidFinishLoad
 * @abstract resize the web view after it finishes loading
 * @discussion resize the web view after it finishes loading
 */
- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    CGFloat height = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
    CGFloat width = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.width"] floatValue];
    
    CGRect frame = aWebView.frame;
    frame.size.height = height;
    frame.size.width = width;
    aWebView.frame = frame;
    CGRect textBackgroundFrame = CGRectMake(40, 0, frame.size.width, frame.size.height);
    self.textBackground.frame = textBackgroundFrame;

}

/*!
 * @function createWebString
 * @abstract create string of web for content
 * @discussion create string of web for content
 */
-(NSString*)createWebString:(NSString*)content
{
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; text-align:center}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body><p>%@</p></body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:20], content];
    return myDescriptionHTML;
}


/*!
 * @function addHighlighToTextWithVideo
 * @abstract addHighlighToTextWithVideo
 * @discussion Add bold, italic, underline to texts which will open video
 */
-(void)addHighlighToTextWithVideo
{
    NSArray *importanceWord = [NSArray arrayWithObjects:@"hat",@"tree",@"day",@"backpack",@"cat",@"walked",@"eat",@"dog",@"happy",@"moon",@"asleep", nil];
    if (self.listOfText != nil)
    {
        for (int i = 0; i < [self.listOfText count]; i++) {
            for (int x = 0 ; x < [importanceWord count]; x++) {
                NSString *newString = [NSString stringWithFormat:@"<a style='background-color:green;'>%@</a>",[importanceWord objectAtIndex:x]];
                /*
                NSString *highlightString = [[self.listOfText objectAtIndex:i] stringByReplacingOccurrencesOfString:[importanceWord objectAtIndex:x] withString:newString];
                [self.listOfText replaceObjectAtIndex:i withObject:highlightString];
                */
                NSString *listOfWords = [self.listOfText objectAtIndex:i];
                
                NSArray *listItems = [listOfWords componentsSeparatedByString:@" "];
                NSMutableArray *list = [NSMutableArray arrayWithArray:listItems];
                listItems = nil;
                for (int y = 0; y < [list count]; y++) {
                    if ([[importanceWord objectAtIndex:x]isEqualToString:[list objectAtIndex:y]]) {
                        [list replaceObjectAtIndex:y withObject:newString];
                    }
                }
                NSString *newSentence = [list componentsJoinedByString:@" "];
                //NSLog(@"%@",newSentence);
                [self.listOfText replaceObjectAtIndex:i withObject:newSentence];
            }
            
            
        }
    }
}

@end
