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


- (id) initWithStoryBooksDB: (NSString *) aBookTitle{
    self = [super init];
    
    self.bookTitle = aBookTitle;
    // Custom initialization
    self.pageText = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        [self.pageText addObject:[NSString stringWithFormat:@"This is page %d for Book %@", i, self.bookTitle ]];
    }
    
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    [self.pageViewController setDataSource:self];
    
    BookPageViewController *book = [self bookPageAtIndex:0];;
    NSArray *viewControllers = [NSArray arrayWithObject:book];
    
    [[self pageViewController] setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.pageViewController.view setFrame: self.view.bounds];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    return self;
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

    // Custom initialization
    self.pageText = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        [self.pageText addObject:[NSString stringWithFormat:@"This is page %d for Book %@", i, self.bookTitle ]];
    }
    
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    [self.pageViewController setDataSource:self];
    
    BookPageViewController *book = [self bookPageAtIndex:0];;
    NSArray *viewControllers = [NSArray arrayWithObject:book];
    
    [[self pageViewController] setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.pageViewController.view setFrame: self.view.bounds];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BookPageViewController *)bookPageAtIndex: (NSUInteger ) index{
    BookPageViewController *bpVC = [[BookPageViewController alloc] init];
    [bpVC setPageText:[self.pageText objectAtIndex:index]];
    return bpVC;
}

- (NSUInteger) indexOfViewController: (BookPageViewController *) viewController {
    return [self.pageText indexOfObject:viewController.pageText];
}

// flip the page to the previous page
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(BookPageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index == 0) {
        return [self bookPageAtIndex:9];
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
    if (index == 9) {
        return [self bookPageAtIndex:0];
    }
    index++;
    return [self bookPageAtIndex:index];
}

@end
