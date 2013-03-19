//
//  BookPageViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "BookPageViewController.h"
#import "XPathQuery.h"

@interface BookPageViewController ()
{
    AVAudioPlayer *theAudio;
    MPMoviePlayerController *mpc;
    int audioShouldPlay;
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

// Do play sound and do animation when view appear
- (void) viewDidAppear:(BOOL)animated {
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(playAnimation)
                                   userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
    
    if (withSound) {
        if (audioShouldPlay == 0){
            [self playAudioAt:positionOfText];
            audioShouldPlay++;
        }
    }
    
    
}

// Stop the audio
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
        pagePath = path;
        audioShouldPlay = 0;
        positionOfText = 0;
        
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
        
        
        
        // adding next page symbol
        [self addNextPButton];
        
        //hide arrow if only have one item in array
        if ([self.listOfText count] == 1)
        {
            self.leftButton.hidden = YES;
            self.rightButton.hidden = YES;
            self.nextPButton.hidden = NO;
        }
    }
    return self;
}

//Add page curl to background imafe
- (void) addNextPButton {
    self.nextPButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.height - 50,
                                                                  0, 50 , 50)];
    UIImage *bookShelfImg = [storyFS getCurlPageImg];
    
    [self.nextPButton setImage:bookShelfImg forState:UIControlStateNormal];
    [self.nextPButton addTarget:self action:@selector(showNextPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextPButton setHidden:TRUE];
    [self.view addSubview:self.nextPButton];
}

//Initialize the background
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

//Initialize the chat bubble
- (void) initChatBublle {
    textBackgroundView = [[UIImageView alloc]init];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *x_percent = [userDefault objectForKey:X_Percentage];
    
    float x_space = 40 * [x_percent floatValue];
    float y_space = 3;

    
    self.webView = [[UIWebView alloc]initWithFrame: CGRectMake(self.backgroundImageView.frame.origin.x + x_space,
                                                               self.backgroundImageView.frame.origin.y + y_space,
                                                               self.backgroundImageView.frame.size.width - (x_space * 2),
                                                               50)];
    
    NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:0]];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    self.webView.opaque = NO;
    [self.webView setDelegate:self];
    [[self.webView scrollView] setScrollEnabled:false];
    
    [self.view addSubview:textBackgroundView];
    [self.view addSubview:self.webView];
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
    if (withSound)
    {
        
        if (durationOfAudio != 1.00)
        {
            
            self.backgroundImageView.animationDuration = durationOfAudio;
        }
        
    }
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
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
    
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        if (withSound) {
            [self playAudioAt:self.positionOfText];
        }
        
        if (self.leftButton.hidden == YES)
        {
            self.leftButton.hidden = NO;
        }
        if (self.positionOfText == [self.listOfText count] - 1)
        {
            [self playAnimation];
            self.rightButton.hidden = YES;
            self.nextPButton.hidden = NO;
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
    self.nextPButton.hidden = YES;
    
    if (self.positionOfText >= 0)
    {   
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
        
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        if (withSound) {
            [self playAudioAt:self.positionOfText];
        }
        
        if (self.positionOfText == 0) {
            [self playAnimation];
        }
        if (self.rightButton.hidden == YES)
        {
            self.rightButton.hidden = NO;
        }
        if (self.positionOfText == 0)
        {
            
            [self playAnimation];
            self.leftButton.hidden = YES;
        }
    }
    else
    {
        self.leftButton.hidden = YES;
    }
}



// play audio at certain index
- (void) playAudioAt:(int) index {
    if (theAudio != nil) {
        [theAudio stop];
    }
    AVAudioPlayer *nextAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[[self listOfAudio] objectAtIndex:index] error:nil];
    theAudio = nextAudio;
    [theAudio prepareToPlay];
    
    float playDelay = .5;
    durationOfAudio = [theAudio duration];
    [theAudio playAtTime:(theAudio.deviceCurrentTime + playDelay)];
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
    
}



/*!
 * @function playAudio
 * @abstract play audio for text
 * @discussion play audio for text
 */
-(void)stopAudio
{
    [theAudio stop];
    
}
/*!
 * @function showToolBar
 * @abstract show or hide the tool bar
 * @discussion show or hide the tool bar when user click on it
 */
- (void)showToolbar
{
    
    if (self.toolBar.hidden == YES) {
        [UIView animateWithDuration:0
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
        
        [UIView animateWithDuration:2
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
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self removeFromParentViewController];
}

//Tap Gesture won't happen when use click on the left and right arrow
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
    [textBackgroundView setHidden:TRUE];
    if ([[self.listOfText objectAtIndex:0] isEqualToString:@""]) {
        [self.webView setFrame:(CGRectMake(0, 0, 0, 0))];
        [self.textBackgroundView setFrame:(CGRectMake(0, 0, 0, 0))];
        [self.webView setHidden:TRUE];
        [self.textBackgroundView setHidden:TRUE];
    }
    else {
        [textBackgroundView setImage:[storyFS getChatBubbleImg]];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        float x_percent = [[userDefault valueForKey:X_Percentage] floatValue];
        
        CGRect frame1 = aWebView.frame;
        frame1.size.height = 1;
        aWebView.frame = frame1;
        CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
        frame1.size = fittingSize;
        aWebView.frame = frame1;

        if (fittingSize.height * x_percent >= 40 * x_percent) {
            self.textBackgroundView.frame = CGRectMake(self.webView.frame.origin.x,
                                                   self.webView.frame.origin.y,
                                                   self.webView.frame.size.width,
                                                   fittingSize.height - 15 * x_percent);
        }
        else {
            self.textBackgroundView.frame = CGRectMake(self.webView.frame.origin.x,
                                                       self.webView.frame.origin.y,
                                                       self.webView.frame.size.width,
                                                       fittingSize.height);    
        }
        [textBackgroundView setHidden:FALSE];
    }
}

/*!
 * @function createWebString
 * @abstract create string of web for content
 * @discussion create string of web for content
 */
-(NSString*)createWebString:(NSString*)content
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    float x_percent = [[userDefault valueForKey:X_Percentage] floatValue];
    
    
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; text-align:center}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body><p>%@</p></body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:20 * x_percent], content];
    return myDescriptionHTML;
}

//Load video when user click on link
- (BOOL) webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if ([[url scheme] isEqualToString:@"keyword"]) {
       
        NSData *data = [[NSData alloc] init];
        NSString *content = [aWebView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
        data = [content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = PerformHTMLXPathQuery(data, @"//@value");
        
        //Hard code to handle 2 anchor tag in one sentence
        if ([result count] > 1) {
            if ([request.URL.host isEqualToString:@"backpack"]) {
                content = result[1];
                NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:[content valueForKey:@"nodeContent"] ofType:@"mp4" inDirectory:@"Dictionary"];
                NSURL *urlVideo = [NSURL fileURLWithPath:stringVideoPath];
                mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
                [mpc setMovieSourceType:MPMovieSourceTypeFile];
                [[self view]addSubview:mpc.view];
                [mpc setFullscreen:YES];
                [mpc play];
            }
            else
            {
                content = result[0];
                NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:[content valueForKey:@"nodeContent"] ofType:@"mp4" inDirectory:@"Dictionary"];
                NSURL *urlVideo = [NSURL fileURLWithPath:stringVideoPath];
                mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
                [mpc setMovieSourceType:MPMovieSourceTypeFile];
                [[self view]addSubview:mpc.view];
                [mpc setFullscreen:YES];
                [mpc play];
            }
        }
        else{
            content = result[0];
            NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:[content valueForKey:@"nodeContent"] ofType:@"mp4" inDirectory:@"Dictionary"];
            NSURL *urlVideo = [NSURL fileURLWithPath:stringVideoPath];
            mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
            [mpc setMovieSourceType:MPMovieSourceTypeFile];
            [[self view]addSubview:mpc.view];
            [mpc setFullscreen:YES];
            [mpc play];
        }
        
    }
    
    return YES;
}

- (void) showNextPage {
/*
    NSLog(@"show Next Page");
    UIViewController *screen = [[UIViewController alloc] init];
    [screen setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:screen animated:YES completion:nil];
*/
}

// hide button
-(void) hideButton:(UIButton *)aButton{
    [aButton setHidden:(![aButton isHidden])];
}

@end
