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
MPMoviePlayerController *mpc;
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
    
    NSLog(@"stringpath =%@",stringVideoPath);
    mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
    mpc.controlStyle = MPMovieControlStyleNone;
    [mpc.view setFrame:self.view.bounds];
    [[self view]addSubview:mpc.view];
    [mpc setFullscreen:YES];
    
    [mpc play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    
     
}

//
-(void) moviePlayerDidFinish:(NSNotification *)notification
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
   
    [self presentViewController:self.bookShelf animated:YES completion:nil];

   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
