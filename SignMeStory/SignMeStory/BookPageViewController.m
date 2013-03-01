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
@synthesize textBackgroundView;
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
}

// database_2012_02_27_JW
- (void) viewDidAppear:(BOOL)animated {
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(playAnimation)
                                   userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
    if (withSound) {
        [self playAudioAt:0];
    }
}

// database_2012_02_27_JW
- (void) viewDidDisappear:(BOOL)animated {
    if (theAudio != nil) {
        [theAudio stop];
    }
}

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andPagePath: (NSString *) path andWithSound: (bool)hasSound{
    self = [super init];
    if (self) {

        storyFS = aStoryFS;
        withSound = hasSound;
        // init backgroundImages
        [self setBackgroundImages: [storyFS getPageBackgrounds:path]];
        [self setListOfText: [storyFS getListOfText:path]];
        if (withSound)
        {
            [self setListOfAudio: [storyFS getListOfAudio:path]];
        }
        // init background animation and chat bubble
        [self initBackgroundAnimation];
        [self initChatBublle];
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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *x_percent = [userDefault objectForKey:X_Percentage];
    
    float x_space = 40 * [x_percent floatValue];
    float y_space = 3;

    textBackgroundView = [[UIImageView alloc]init];
    [textBackgroundView setFrame: CGRectMake(self.backgroundImageView.frame.origin.x + x_space,
                                             self.backgroundImageView.frame.origin.y + y_space,
                                             self.backgroundImageView.frame.size.width - (x_space * 2),
                                             30)];
    
    [textBackgroundView setImage:[storyFS getChatBubbleImg]];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(textBackgroundView.frame.origin.x,
                                                              textBackgroundView.frame.origin.y,
                                                              textBackgroundView.frame.size.width,
                                                              textBackgroundView.frame.size.height)];
    //[self addHighlighToTextWithVideo];
    NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:0]];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    self.webView.opaque = NO;
    [self.webView setDelegate:self];
    [[self.webView scrollView] setScrollEnabled:false];

    [self.view addSubview:textBackgroundView];
    [self.view addSubview:self.webView];
    
    //[self.backgroundImageView bringSubviewToFront:self.webView];
    //[self.view addSubview: webView];
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
            [self showNextPage];
            [self playAnimation];
            self.rightButton.hidden = YES;
        }
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
    
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        if (withSound) {
            [self playAudioAt:self.positionOfText];// database_2012_02_27_JW
        }
    
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
        
        if (self.positionOfText == 0) {
            [self playAnimation];
        }
        if (self.rightButton.hidden == YES)
        {
            self.rightButton.hidden = NO;
        }
        if (self.positionOfText == 0)
        {
            [self showNextPage];
            [self playAnimation];
            self.leftButton.hidden = YES;
        }
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
        
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        if (withSound) {
            [self playAudioAt:self.positionOfText];// database_2012_02_27_JW
        }
    }
    else
    {
        self.leftButton.hidden = YES;
    }
}



// database_2012_02_27_JW
- (void) playAudioAt:(int) index {
    if (theAudio != nil) {
        [theAudio stop];
    }
    AVAudioPlayer *nextAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[[self listOfAudio] objectAtIndex:index] error:nil];
    theAudio = nextAudio;
    [theAudio prepareToPlay];
    
    float playDelay = .5;
    [theAudio playAtTime:(theAudio.deviceCurrentTime + playDelay)];
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
    
    UIImage *homeIconImg = [storyFS getHomeImg];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeIconImg style:UIBarButtonItemStylePlain target:self action:@selector(quit)];
    if (withSound) {
        NSArray *buttons = [[NSArray alloc]
                            initWithObjects:homeButton,flexibleSpace,playButton, pauseButton,stopButton,flexibleSpace, nil];
        self.toolBar.items = buttons;
    }
    else {
        NSArray *buttons = [[NSArray alloc] initWithObjects:homeButton, nil];
        self.toolBar.items = buttons;
    }
    
}


/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self removeFromParentViewController];
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
    if ([[self.listOfText objectAtIndex:0] isEqualToString:@""]) {
        [self.webView setFrame:(CGRectMake(0, 0, 0, 0))];
        [self.textBackgroundView setFrame:(CGRectMake(0, 0, 0, 0))];
        
    }
    else {
        CGRect frame1 = aWebView.frame;
        frame1.size.height = 1;
        aWebView.frame = frame1;
        CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
        frame1.size = fittingSize;
        aWebView.frame = frame1;

        self.textBackgroundView.frame = CGRectMake(self.webView.frame.origin.x,
                                                   self.webView.frame.origin.y,
                                                   self.webView.frame.size.width,
                                                   fittingSize.height - 15);
    }
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

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"keyword"]) {
        NSLog(@"%@", request);
        NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:@"hat" ofType:@"mp4" inDirectory:@"Dictionary"];
        NSURL *urlVideo = [NSURL fileURLWithPath:stringVideoPath];
        mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
        [mpc setMovieSourceType:MPMovieSourceTypeFile];
        [[self view]addSubview:mpc.view];
        [mpc setFullscreen:YES];
        [mpc play];
    }
    
    return YES;
}

- (void) showNextPage {
    NSLog(@"show Next Page");
    UIViewController *screen = [[UIViewController alloc] init];
    [screen setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:screen animated:YES completion:nil];
}
@end
