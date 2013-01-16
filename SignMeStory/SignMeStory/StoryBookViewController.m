//
//  StoryBookViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "StoryBookViewController.h"

@interface StoryBookViewController ()
{
    AVAudioPlayer *theAudio;
}
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
    NSURL *url  = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/GreenbeaniesParagraph1.txt",[[NSBundle mainBundle] resourcePath]]];
    
    NSError *err;
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
    
    self = [super init];

    self.bookTitle = aBookTitle;
    self.pageText = [[NSMutableArray alloc] init];
    self.listOfBackgroundImageName = [[NSMutableArray alloc] initWithObjects:@"storyboardscreen1.png",@"screen2-1henryandcecewithbackground.png",@"screen3-1background+henryandcece.png",@"storyboard4background.png", nil];
    NSLog(@"%i",[self.listOfBackgroundImageName count]);
    self.listOfBackgroundImage = [[NSMutableArray alloc] initWithCapacity:[self.listOfBackgroundImageName count]];
    
    // creates text in the book page.
    // this loop should be replace when actuall book pages are implemented
    for (int i = 0; i < 4; i ++) {
        //[self.pageText addObject:[NSString stringWithFormat:@"This is page %d for Book %@", i, self.bookTitle ]];
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
    //add the play button
    [self addPlayButton];
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
-(void)playAudio {
    
    //NSURL *url  = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/test1.mp3",[[NSBundle mainBundle] resourcePath]]];
    
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"M4A"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    //NSURL *url = [ NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/test1.mp3", [[NSBundle mainBundle] resourcePath]]];
    NSLog(@"%@",url);
    NSError *error;
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    theAudio.numberOfLoops = 0;
    if (theAudio == nil)
    {
        NSLog(@"%@",[error description]);
    }
    else
    {
        [theAudio play];
        NSLog(@"play");
    }
    
    
    
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

@end
