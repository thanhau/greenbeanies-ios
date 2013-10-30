//
//  CoverPageViewController.m
//  SignMeStory
//
//  Created by test on 2/19/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "CoverPageViewController.h"

@interface CoverPageViewController () {
    float x_percent;
    float y_percent;
    MPMoviePlayerController *mpc;
    CGRect sceneFrame;
}

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


- (void) viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear:animated];
    
   
}

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle {
    self = [super init];
    if (self) {
        NSLog(@"money");
        storyFS = aStoryFS;
        title = aBookTitle;
        sceneFrame = [self getScreenFrameForCurrentOrientation];
        UIImage *coverPage = [storyFS getCoverImg: title];
        if (coverPage == nil)  {
            valid = false;
        }
        else {
            if ([storyFS getNumberOfPages:title] > 0) {
                valid = true;
                [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                x_percent = [[userDefault objectForKey:X_Percentage] floatValue];
                y_percent = [[userDefault objectForKey:Y_Percentage] floatValue];
            
                self.backgroundImageView = [[UIImageView alloc]init];
                [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
                [self.backgroundImageView setImage: coverPage];
                [self.view addSubview:self.backgroundImageView];
                [self addReadToMeButton];
                [self addReadByMyselfButton];
                [self addBookShelfButton];
                [self addTutorialButton];
            }
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

     

}

// force the orientation to landscape
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
/*!
 * @function addReadToMeButton
 * @abstract adding an read to me button in the view 
 * @discussion It creates button that let user listen to the audio
 */
- (void) addReadToMeButton {
    UIButton *readToMeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.origin.x, self.backgroundImageView.frame.size.height - 90, 70, 70)];
    UIImage *readToMeImage = [storyFS getReadToMeImg:title];
    
    [readToMeButton setImage:readToMeImage forState:UIControlStateNormal];
    [readToMeButton addTarget:self action:@selector(readToMe) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: readToMeButton];
}

/*!
 * @function addReadByMyselfButton
 * @abstract adding an read by myself button in the view
 * @discussion It creates button that don't let user listen to the audio
 */
- (void) addReadByMyselfButton {
    UIButton *readByMyselfButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 4, self.backgroundImageView.frame.size.height - 90, 70, 70)];
    UIImage *readByMyselfImage = [storyFS getReadByMyselfImg:title];
    
    [readByMyselfButton setImage:readByMyselfImage forState:UIControlStateNormal];
    [readByMyselfButton addTarget:self action:@selector(readByMyself) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: readByMyselfButton];
}

/*!
 * @function addTutorialButton
 * @abstract adding tutorial button
 * @discussion It creates tutorial button that show video how to use the app
 */
- (void) addTutorialButton {
    UIButton *addTutorialButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width - 100, self.backgroundImageView.frame.size.height - 90, 70, 70)];
   
    UIImage *demoIcon = [storyFS getDemoImg:title];
    
    [addTutorialButton setImage:demoIcon forState:UIControlStateNormal];
    //[addTutorialButton addTarget:self action:@selector(displayTutorial) forControlEvents:UIControlEventTouchUpInside];
    [addTutorialButton addTarget:self action:@selector(displayListOfVocabulary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addTutorialButton];
}

/*!
 * @function addReadToMe
 * @abstract allow the audio work
 * @discussion allow the audio work
 */
-(void) readToMe
{
    /*
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:true];
    [aNewBook setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];
     */
    TestViewController *aNewBook = [[TestViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:true];
    [aNewBook setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];
}
/*!
 * @function readByMyself
 * @abstract don't allow the audio work
 * @discussion don't allow the audio work
 */
-(void) readByMyself
{
    /*
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:false];
    [aNewBook setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];
     */
    TestViewController *aNewBook = [[TestViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:false];
    [aNewBook setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];

}

/*!
 * @function displayListOfVocabulary
 * @abstract display list of book contain video of sign language
 * @discussion display list of book contain video of sign language
 */
-(void) displayListOfVocabulary
{
    UINavigationController *Controller = [[UINavigationController alloc] init];
    //LoginViewController is a sub class of UITableviewController
    
    ListOfBookVocabularyViewController *listOfVocabulary = [[ListOfBookVocabularyViewController alloc] initWithStoryBooksFS:storyFS andTitle:title];
    [listOfVocabulary setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [listOfVocabulary.view setFrame:self.view.bounds];
    //[self presentViewController:listOfVocabulary animated:YES completion:nil];
    
    Controller.viewControllers=[NSArray arrayWithObject:listOfVocabulary];
    
    [self presentModalViewController:Controller animated:YES];
     

    
}




/*!
 * @function displayTutorial
 * @abstract display tutorial video
 * @discussion display tutorial video
 */
-(void) displayTutorial
{
    //NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:@"tutorial" ofType:@"mp4" inDirectory:@"Dictionary"];
    NSURL *urlVideo = [NSURL URLWithString:@"http://hidevmobile.com/gbv/tutorial.mp4"];
    NSLog(@"url:%@",urlVideo );
    mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
    [[self view]addSubview:mpc.view];
    [mpc setFullscreen:YES];
    
    [mpc play];
}

- (bool) isAValidBook {
    return valid;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * @function addBookShelfButton
 * @abstract adding an exit button in the view so user can go back to bookshelf
 * @discussion It creates button that exit current book and redirect to the bookshelf
 */
- (void) addBookShelfButton {
    UIButton *bookShelfButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width - 200, self.backgroundImageView.frame.size.height - 90, 70, 70)];
    UIImage *bookShelfImg = [storyFS getbookshelfImg:title];
    
    [bookShelfButton setImage:bookShelfImg forState:UIControlStateNormal];
    [bookShelfButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: bookShelfButton];
}

/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGRect)getScreenFrameForCurrentOrientation {
    return [self getScreenFrameForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect fullScreenRect = screen.bounds;
    screen = nil;
    BOOL statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    
    //implicitly in Portrait orientation.
    if(orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft){
        CGRect temp = CGRectZero;
        temp.size.width = fullScreenRect.size.height;
        temp.size.height = fullScreenRect.size.width;
        fullScreenRect = temp;
    }
    
    if(!statusBarHidden){
        CGFloat statusBarHeight = 20;//Needs a better solution, FYI statusBarFrame reports wrong in some cases..
        fullScreenRect.size.height -= statusBarHeight;
    }
    
    return fullScreenRect;
}

@end
