//
//  StoryBookViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "StoryBookViewController.h"
#import "XPathQuery.h"

@interface StoryBookViewController ()

@end

@implementation StoryBookViewController
@synthesize bookPath;
@synthesize bookTitle;

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle andWithSound: (bool)hasSound{
    self = [super init];
    self.bookTitle = aBookTitle;
    self.pageText = [[NSMutableArray alloc] init];
    self.pageNumber = [[NSMutableArray alloc] init];
    
    storyFS = aStoryFS;
    nPages = [aStoryFS getNumberOfPages:bookTitle];
    [aStoryFS setCurrentBookTitle:aBookTitle];
    hasVoiceOrNot = hasSound;
    [self initBook];
    
    return self;
}

- (void) initBook{
    // creates text in the book page.
    // this loop should be replace when actuall book pages are implemented
    for (int i = 0; i < nPages; i ++) {        
        [self.pageText addObject:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]];
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
    
 
}


// return the view controller represents the book at the index.
- (BookPageViewController *)bookPageAtIndex: (NSUInteger ) index{
    BookPageViewController *bpVC = [[BookPageViewController alloc] initWithStoryBooksFS:storyFS andPagePath:[self.pageText objectAtIndex:index] andWithSound:hasVoiceOrNot];
    [bpVC setPageText:[self.pageText objectAtIndex:index]];
    return bpVC;
}

// return the index of desired view controller
- (NSUInteger) indexOfViewController: (BookPageViewController *) viewController {
    //[viewController.listOfText objectAtIndex:0]
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
    BookPageViewController *bpVC = [self bookPageAtIndex:index];
    if (index == [self.pageText count ] - 1) {
        bpVC.nextPButton.hidden =TRUE;
    }
    return bpVC;
}

// force the orientation to landscape
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}



/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
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









@end
