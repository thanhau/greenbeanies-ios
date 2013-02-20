//
//  CoverPageViewController.m
//  SignMeStory
//
//  Created by test on 2/19/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "CoverPageViewController.h"

@interface CoverPageViewController ()

@end

@implementation CoverPageViewController

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
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    // set page background
    UIImage *coverPage = [UIImage imageNamed:@"CoverShot.jpg"];
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.backgroundImageView setImage:coverPage];
   
    
    
    
    
    [self.view addSubview:self.backgroundImageView];
    [self addReadToMeButton];
    
}

// force the orientation to landscape
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

/*!
 * @function addReadToMeButton
 * @abstract adding an read to me button in the view 
 * @discussion It creates button that let user listen to the audio
 */
- (void) addReadToMeButton {
    UIButton *readToMeButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 100, 30, 30)];
    UIImage *readToMeImage = [UIImage imageNamed:@"readToMe.png"];
    
    [readToMeButton setImage:readToMeImage forState:UIControlStateNormal];
    [readToMeButton addTarget:self action:@selector(readToMe) forControlEvents:UIControlEventTouchUpInside];
    //[self.leftButton addTarget:self action:@selector(goToPreviousText) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview: readToMeButton];
    
    
}
/*!
 * @function addReadToMe
 * @abstract allow the audio work
 * @discussion allow the audio work
 */
-(void) readToMe
{
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksDB: [NSString stringWithFormat: @"Test %d", 1]];
    //[aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
