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
    UIImage *imgChatBubble = [UIImage imageNamed:@"screen1chatbubble.png"];
    UIImageView *textBackground = [[UIImageView alloc]initWithImage:imgChatBubble];
    

    // set page background
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.backgroundImageView setImage:self.backgroundImage];
    [self.view addSubview:self.backgroundImageView];
    
    // set text frame
    textBackground.frame = CGRectMake(self.view.frame.origin.x + 20, self.view.frame.origin.y - 50, 400, 700);
        
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 20, self.view.frame.origin.y + 60, textBackground.frame.size.width - 50, textBackground.frame.size.height - 100)];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setTextColor:[UIColor whiteColor]];
    [self.textView setText:self.pageText];
    [self.backgroundImageView addSubview:textBackground];
    
    [textBackground addSubview:self.textView];

    /*
    [self.view setBackgroundColor:[UIColor redColor]];
    self.pageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.pageTextLabel setTextAlignment:NSTextAlignmentLeft];
    [self.pageTextLabel setBackgroundColor: [UIColor redColor]];
    [self.pageTextLabel setTextColor:[UIColor whiteColor]];
    [self.backgroundImageView addSubview:self.pageTextLabel];
    [self.pageTextLabel setText:self.pageText];
     */
    
    CGRect frame = self.textView.frame;
    frame.size.height = self.textView.contentSize.height;
    self.textView.frame = frame;
    
    
    /*
    // redraw the image to fit |yourView|'s size
    UIGraphicsBeginImageContextWithOptions(self.textView.frame.size, NO, 0);
    [imgChatBubble drawInRect:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, self.textView.frame.size.height)]; //hardcoding for location will fix it later
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.textView setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
     */
    
    //Create the path contain location of audio file 
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"M4A"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    
    NSError *error;
    //Create AVAudio Player with 
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    [self addPauseButton];
    [self addPlayButton];
    [self addStopButton];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * @function addPauseButton
 * @abstract adding an pause audio button in the view so user can pause the audio
 * @discussion It creates button that pause audio
 */
- (void) addPauseButton {
    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 75, 30, 30)];
    [pauseButton setTitle: [NSString stringWithFormat: @"PA"]
                forState: UIControlStateNormal];
    
    [pauseButton setBackgroundColor: [UIColor grayColor]];
    
    
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
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 40, 30, 30)];
    [playButton setTitle: [NSString stringWithFormat: @"P"]
                forState: UIControlStateNormal];
    
    [playButton setBackgroundColor: [UIColor grayColor]];
    
    [playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: playButton];
    
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
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 110, 30, 30)];
    [stopButton setTitle: [NSString stringWithFormat: @"S"]
                forState: UIControlStateNormal];
    
    [stopButton setBackgroundColor: [UIColor grayColor]];
    
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
