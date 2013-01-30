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
}
@end

@implementation BookPageViewController
@synthesize pageText;
@synthesize backgroundImageView;
@synthesize backgroundImage;
@synthesize textView;
@synthesize animationImage;
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
    //UIImage *img = [UIImage imageNamed:@"storyboardscreen1.png"];
    //UIImage *imgChatBubble = [UIImage imageNamed:@"screen1chatbubble.png"];
     UIImageView *textBackground = [[UIImageView alloc]init];
    

    // set page background
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    //[self.backgroundImageView setImage:self.backgroundImage];
    [self.backgroundImageView setImage:[self.animationImage objectAtIndex:0]];
    
    self.backgroundImageView.animationImages = self.animationImage;
    self.backgroundImageView.animationDuration = 1;
    
    self.backgroundImageView.animationRepeatCount = 1;
    //[self.backgroundImageView startAnimating];
    //NSLog(@"%@",self.animationImage);
    [self.view addSubview:self.backgroundImageView];
    
    
    // set text background
    textBackground.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 400, 300);
    
    // set text frame
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.origin.x, self.backgroundImageView.frame.origin.y, 400, 300)];
    [self.textView setFont: [UIFont fontWithName:@"System" size:30]];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setTextColor:[UIColor blackColor]];
    [self.textView setText:self.pageText];
    
    
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(animation)
                                   userInfo:nil
                                    repeats:NO];
    //NSUInteger numberOfLine = self.textView.contentSize.height / self.textView.font.lineHeight;

    //NSLog(@"Lines %u",numberOfLine);
    //[textBackground setFrame:CGRectMake(self.view.frame.origin.x + 40, self.view.frame.origin.y, 300, numberOfLine * 10)];
    
    //UIImage *img = [UIImage imageNamed:@"storyboardscreen1.png"];
    UIImage *imgChatBubble = [UIImage imageNamed:@"Untitled-4.png"];
    
    
    [self.backgroundImageView addSubview:textBackground];
    //[self.backgroundImageView addSubview:self.textView];
    
    [textBackground addSubview:self.textView];
    //[self.textView addSubview: textBackground];
    
    //Change the size frame according to height of text
    CGRect frame = self.textView.frame;
    frame.size.height = self.textView.contentSize.height;
    frame.size.width = self.textView.contentSize.width;
    self.textView.frame = frame;
    
    
    CGRect textBackgroundFrame = CGRectMake(40, 0, self.textView.frame.size.width, self.textView.frame.size.height);
    [textBackground setFrame: textBackgroundFrame];
    
    
    [textBackground setImage:[self imageWithImage:imgChatBubble convertToSize:self.textView.frame.size]];
    
        
    //Create the path contain location of audio file 
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"M4A"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    
    NSError *error;
    //Create AVAudio Player with 
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //Add audio control button to the view
    //[self addPauseButton];
    //[self addPlayButton];
    //[self addStopButton];
    
    
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


@end
