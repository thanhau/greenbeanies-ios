//
//  StoryBookViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "StoryBookViewController.h"

@interface StoryBookViewController ()

@end

@implementation StoryBookViewController
@synthesize bookTitle;

/*!
 * @function initWithStoryBooksDB
 * @abstract custom override initialization method
 * @discussion It initialize all the instance and creates pages for this book.
 * @return this view controller
 */
- (id) initWithStoryBooksDB: (NSString *) aBookTitle{
   
    
    self = [super init];
    self.listOfAllAnimation = [[NSMutableArray alloc] init];
    self.listOfAnimation = [[NSMutableArray alloc] init];
    
    //NSArray *listNameOfImage = [[NSArray alloc] initWithObjects:@"BusMoving",@"BusStopLeaving",@"CatJumping",@"CityView", nil];
    NSArray *listNameOfImage = [[NSArray alloc] initWithObjects:@"CatJumping",@"CityView", nil];
    for (int y = 0; y < 2; y++) {
        NSMutableArray *listImage = [[NSMutableArray alloc] initWithCapacity:4];
        for (int i = 1; i <= 4; i++)
        {
            
            NSString *imgageName = [NSString stringWithFormat:@"%@%i.jpg",[listNameOfImage objectAtIndex:y],i];
            
            UIImage *img = [UIImage imageNamed:imgageName];
            [listImage addObject:img];
            
        }
        [self.listOfAllAnimation addObject:listImage];
        
    }
    
    /*
    for (int y = 0; y < 2; y++) {
        for (int i = 1; i <= 4; i++)
        {
            
            NSString *imgageName = [NSString stringWithFormat:@"%@%i.png",[listNameOfImage objectAtIndex:y],i];
            UIImage *img = [UIImage imageNamed:imgageName];
            
            if (img == nil)
            {
                NSLog(@"No image");
            }
            else
            {
                [self.listOfAnimation addObject:img];
                NSLog(@"Have image");
            }
            
        }
        
        //[self.listOfAllAnimation addObject:self.listOfAnimation];
    }
    for (int y = 2; y < 4; y++) {
        for (int i = 1; i <= 4; i++)
        {
            
            NSString *imgageName = [NSString stringWithFormat:@"%@%i.jpg",[listNameOfImage objectAtIndex:y],i];
            
            UIImage *img = [UIImage imageNamed:imgageName];
            [self.listOfAnimation addObject:img];
            
        }
        [self.listOfAllAnimation addObject:self.listOfAnimation];
    }
    //NSLog(@"%i",[self.listOfAllAnimation count]);
    */
    
    self.bookTitle = aBookTitle;
    self.pageText = [[NSMutableArray alloc] init];
    self.listOfBackgroundImageName = [[NSMutableArray alloc] initWithObjects:@"storyboardscreen1.png",@"screen2-1henryandcecewithbackground.png",@"screen3-1background+henryandcece.png",@"storyboard4background.png", nil];
    
    //self.listOfStoryText = [[NSMutableArray alloc] initWithObjects:@"GreenbeaniesParagraph1.txt",@"GreenbeaniesParagraph2.txt",@"GreenbeaniesParagraph3.txt",@"GreenbeaniesParagraph4.txt", nil];
    self.listOfStoryText = [[NSMutableArray alloc] initWithObjects:@"GreenbeaniesParagraph1.txt",@"GreenbeaniesParagraph2.txt", nil];
    self.listOfBackgroundImage = [[NSMutableArray alloc] initWithCapacity:[self.listOfBackgroundImageName count]];
    
    // creates text in the book page.
    // this loop should be replace when actuall book pages are implemented
    for (int i = 0; i < 2; i ++) {
        
        //[self.pageText addObject:[NSString stringWithFormat:@"This is page %d for Book %@", i, self.bookTitle ]];
        
        NSURL *url  = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],[self.listOfStoryText objectAtIndex:i]]];
        
        NSError *err;
        NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
        
        [self.pageText addObject:urlString];
    }
    
    // create background image in book page.
    for (int i = 0 ; i < [self.listOfBackgroundImageName count]; i++) {
       
        UIImage *img = [UIImage imageNamed:[self.listOfBackgroundImageName objectAtIndex:i]];
        [self.listOfBackgroundImage addObject:img];
    }
    
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    [self.pageViewController setDataSource:self];
    
    // Begin the book with page index 0
    BookPageViewController *book = [self bookPageAtIndex:0];;
    NSArray *viewControllers = [NSArray arrayWithObject:book];
    
    [[self pageViewController] setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.pageViewController.view setFrame: self.view.bounds];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // adding the exit button on the top left corner
    [self addExitButton];
    
    // adding toolbar at bottom
    [self addToolBar];
            
    
        
    
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
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
    // init the singe tap gesture
    self.singeTap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showToolbar)];
    
    self.singeTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singeTap];
    self.view.userInteractionEnabled = YES;
    
    [self.view addSubview:self.toolBar];
   
    //create space to aligment the toolbar item
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //create play button
    UIBarButtonItem *playButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
     target:self
     action:@selector(play)];
    
    //create pause button
    UIBarButtonItem *pauseButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemPause
     target: self
     action:@selector(pause)];
    
    //create bar button
    UIBarButtonItem *stopButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemStop
     target: self
     action:@selector(stop)];
    
    NSArray *buttons = [[NSArray alloc]
                        initWithObjects:flexibleSpace,playButton, pauseButton,stopButton,flexibleSpace, nil];
    
    self.toolBar.items = buttons;

}

/*!
 * @function addExitButton
 * @abstract adding an exit button in the view so user can go back to bookshelf
 * @discussion It creates button that exit current book and redirect to the bookshelf
 */
- (void) addExitButton {
    UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    [exitButton setTitle: [NSString stringWithFormat: @"Q"]
                forState: UIControlStateNormal];

    [exitButton setBackgroundColor: [UIColor grayColor]];
    
    [exitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: exitButton];
}

/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// return the view controller represents the book at the index.
- (BookPageViewController *)bookPageAtIndex: (NSUInteger ) index{
    BookPageViewController *bpVC = [[BookPageViewController alloc] init];
    [bpVC setPageText:[self.pageText objectAtIndex:index]];
    
    [bpVC setAnimationImage:[self.listOfAllAnimation objectAtIndex:index]];
    
    [bpVC setBackgroundImage:[self.listOfBackgroundImage objectAtIndex:index]];
    return bpVC;
}

// return the index of desired view controller
- (NSUInteger) indexOfViewController: (BookPageViewController *) viewController {
    return [self.pageText indexOfObject:viewController.pageText];
    
}

// flip the page to the previous page
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(BookPageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    //Made it so that you can't flip from page 0 to the last backwards
    if (index == 0) {
        return nil;
    }
    index--;
    return [self bookPageAtIndex:index];
}

// flipping the page to the next page
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(BookPageViewController *)viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    //Made it so that you can't flip from the last to the first page forwards
    if (index == [self.pageText count] - 1) {
        return nil;
    }
    index++;
    return [self bookPageAtIndex:index];
}

// force the orientation to landscape
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}


// handling interruption at beginning
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [player pause];
}

// handling interruption at the end
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    
    [player play];

}

// handling when audio fininsh playing
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag == TRUE)
    {
        int count = [self indexOfViewController: (BookPageViewController *)self.parentViewController];
        NSLog(@"This page is %i", count);
    }
}

- (void)showToolbar
{
    NSLog(@"tap");
    if (self.toolBar.hidden == YES) {
        self.toolBar.hidden = NO;
        /*
        // Move the frame out of sight
        CGRect frame = self.toolBar.frame;
        frame.origin.y = -frame.size.height;
        self.toolBar.frame = frame;
        
        // Display it nicely
        self.toolBar.hidden = NO;
        frame.origin.y = 0.0;
        [self.view bringSubviewToFront:self.toolBar];
        
        [UIView animateWithDuration:0.3
                         animations:^(void) {
                             self.toolBar.frame = frame;
                         }
         ];
         */
        [self.toolBar setAlpha:1];
    }
    else if (self.toolBar.hidden == NO) {
        
        [UIView animateWithDuration:0.5
                         animations:^(void) {
                             [self.toolBar setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = YES;
                         }
         ];
        
    }
}

- (CGRect)frameForOrientation:(UIInterfaceOrientation)theOrientation
{
    UIScreen *screen = [UIScreen mainScreen];
    CGRect fullScreenRect = screen.bounds;      // always implicitly in Portrait orientation.
    CGRect appFrame = screen.applicationFrame;
    
    // Find status bar height by checking which dimension of the applicationFrame is narrower than screen bounds.
    // Little bit ugly looking, but it'll still work even if they change the status bar height in future.
    float statusBarHeight = MAX((fullScreenRect.size.width - appFrame.size.width), (fullScreenRect.size.height - appFrame.size.height));
    
    // Initially assume portrait orientation.
    float width = fullScreenRect.size.width;
    float height = fullScreenRect.size.height;
    
    // Correct for orientation.
    if (UIInterfaceOrientationIsPortrait(theOrientation)) {
        width = fullScreenRect.size.height;
        height = fullScreenRect.size.width;
    }
    
    // Account for status bar, which always subtracts from the height (since it's always at the top of the screen).
    //height -= statusBarHeight;
    
    return CGRectMake(0, statusBarHeight, width, height);
}

- (CGSize)viewSizeForOrientation:(UIInterfaceOrientation)theOrientation
{
    CGRect frame = [self frameForOrientation:theOrientation];
    return CGSizeMake(frame.size.width, frame.size.height);
}


@end
