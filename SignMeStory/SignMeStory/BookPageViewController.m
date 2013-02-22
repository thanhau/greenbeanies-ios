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
@synthesize pageText;
@synthesize backgroundImageView;
@synthesize backgroundImage;
@synthesize textView;
@synthesize animationImage;
@synthesize webView;
@synthesize positionOfText;
@synthesize listOfAudio;

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
    
     self.textBackground = [[UIImageView alloc]init];
    

    self.positionOfText = 0;
    
    // set page background
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    //[self.backgroundImageView setImage:self.backgroundImage];
    
    
    [self.backgroundImageView setImage:[self.animationImage objectAtIndex:0]];
    
    if (self.animationImage != nil) {
        self.backgroundImageView.animationImages = self.animationImage;
        self.backgroundImageView.animationDuration = 1;
        
        self.backgroundImageView.animationRepeatCount = 1;
    }
    
    //[self.backgroundImageView startAnimating];
    //NSLog(@"%@",self.animationImage);
    [self.view addSubview:self.backgroundImageView];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(self.backgroundImageView.frame.origin.x, self.backgroundImageView.frame.origin.y, 400, 50)];
    //NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    //NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:0] ];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    
    self.webView.opaque = NO;
    [self.webView setDelegate:self];
    
    
    
    // set text background
    self.textBackground.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 400, 300);
    
    // set text frame
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.origin.x, self.backgroundImageView.frame.origin.y, 400, 300)];
    [self.textView setFont: [UIFont fontWithName:@"Arial" size:20]];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setTextColor:[UIColor blackColor]];
    //[self.textView setText:[self.listOfText objectAtIndex:0]];
    [self.textView setText:self.pageText];
    [self.textView setDelegate:self];
    
    
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(animation)
                                   userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
    
    //NSUInteger numberOfLine = self.textView.contentSize.height / self.textView.font.lineHeight;

    
    UIImage *imgChatBubble = [UIImage imageNamed:@"bubble80.png"];
    
    
    [self.backgroundImageView addSubview:self.textBackground];
    
    
    //[self.textBackground addSubview:self.textView];
    [self.textBackground addSubview:self.webView];
    
    //Change the size frame according to height of text
    /*
    CGRect frame = self.textView.frame;
    frame.size.height = self.textView.contentSize.height;
    frame.size.width = self.textView.contentSize.width;
    self.textView.frame = frame;
    */
    
    CGRect frame = self.textView.frame;
    frame.size.height = self.textView.contentSize.height;
    frame.size.width = self.textView.contentSize.width;
    self.textView.frame = frame;
    
    //CGRect textBackgroundFrame = CGRectMake(40, 0, self.textView.frame.size.width, self.textView.frame.size.height);
    CGRect textBackgroundFrame = CGRectMake(40, 0, self.webView.frame.size.width, self.webView.frame.size.height);
    [self.textBackground setFrame: textBackgroundFrame];
    
    
    [self.textBackground setImage:[self imageWithImage:imgChatBubble convertToSize:self.textView.frame.size]];
    //[textBackground setBackgroundColor:[UIColor whiteColor]];
    //textBackground.opaque = NO;
    /*
    //Create the path contain location of audio file
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:[listOfAudio objectAtIndex:positionOfText]  ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    
    NSError *error;
    //Create AVAudio Player with
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [theAudio setDelegate:self];
    //[theAudio play];
     */
    //adding arrow
    [self addLeftButton];
    [self addRightButton];
    // adding toolbar at bottom
    [self addToolBar];
    //[self addPlayVideoButton];
<<<<<<< HEAD
=======
    
    //hide arrow if only have one item in array
    if ([self.listOfText count] == 1)
    {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
    }
    
    

    
    
    
    
>>>>>>> Add all the page
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
-(void) animation{
    self.backgroundImageView.animationImages = self.animationImage;
    self.backgroundImageView.animationDuration = 1;
    
    self.backgroundImageView.animationRepeatCount = 1;
    [self.backgroundImageView startAnimating];
    //[self.backgroundImageView setImage:[self.animationImage objectAtIndex:[self.animationImage count] - 1]];
    
    

    

    
}

/*!
 * @function addLeftButton
 * @abstract adding an left button in the view so user can go back to previous text
 * @discussion It creates button that let user go back to previous text
 */
- (void) addLeftButton {
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 50, 50, 50)];
    UIImage *leftArrow = [UIImage imageNamed:@"greenarrowLeft.png"];
    
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
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.height - 30, 5, 30, 30)];
    UIImage *rightArrow = [UIImage imageNamed:@"greenarrow.png"];
    
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
        
        
        /*
        CGRect frame = self.textView.frame;
        frame.size.height = self.textView.contentSize.height;
        frame.size.width = self.textView.contentSize.width;
        self.textView.frame = frame;
        
        
        CGRect textBackgroundFrame = CGRectMake(40, 0, self.textView.frame.size.width, self.textView.frame.size.height);
        [self.textBackground setFrame: textBackgroundFrame];
         */
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

        /*
        NSString *stringPath = [[NSBundle mainBundle]pathForResource:[listOfAudio objectAtIndex:positionOfText]  ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:stringPath];
        
        NSError *error;
        //Create AVAudio Player with
        theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [theAudio play];
         */
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
        /*
        //Change the size frame according to height of text
        
        CGRect frame = self.textView.frame;
        frame.size.height = self.textView.contentSize.height;
        frame.size.width = self.textView.contentSize.width;
        self.textView.frame = frame;
        
        
        CGRect textBackgroundFrame = CGRectMake(40, 0, self.textView.frame.size.width, self.textView.frame.size.height);
        [self.textBackground setFrame: textBackgroundFrame];
        */
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
        /*
        NSString *stringPath = [[NSBundle mainBundle]pathForResource:[listOfAudio objectAtIndex:positionOfText]  ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:stringPath];
        
        NSError *error;
        //Create AVAudio Player with
        theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [theAudio play];
        */
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
    UIBarButtonItem *quitButton = [[UIBarButtonItem alloc] initWithTitle:@"Q" style:UIBarButtonItemStylePlain target:self action:@selector(quit)];
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
                                   "body {font-family: \"%@\"; font-size: %@;}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body><p>%@</p></body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:20], content];
    return myDescriptionHTML;
}


@end
