//
//  IntroVideoViewController.m
//  SignMeStory
//
//  Created by Thanh Au on 9/4/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "IntroVideoViewController.h"

@interface IntroVideoViewController ()
{
MPMoviePlayerController *mediaPlayer;
}
@end

@implementation IntroVideoViewController

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
	// Do any additional setup after loading the view.
    self.bookShelf = [[BookshelfViewController alloc]init];
    NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:@"Signmeastoryopeningscreen" ofType:@"m4v" inDirectory:@"Dictionary"];
    NSURL *urlVideo = [[NSURL alloc] initFileURLWithPath:stringVideoPath];
  
    mediaPlayer = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
    mediaPlayer.controlStyle = MPMovieControlStyleNone;
    [mediaPlayer.view setFrame:self.view.bounds];
    [[self view]addSubview:mediaPlayer.view];
    //[mpc setFullscreen:YES];
    
    [mediaPlayer play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    stringVideoPath = nil;
    urlVideo = nil;
    
 
}
- (void)viewDidUnload
{
    mediaPlayer = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
     
}

//
-(void) moviePlayerDidFinish:(NSNotification *)notification
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [mediaPlayer.view removeFromSuperview];
    mediaPlayer = nil;
    [self presentViewController:self.bookShelf animated:YES completion:nil];

   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    mediaPlayer = nil;
}

@end
