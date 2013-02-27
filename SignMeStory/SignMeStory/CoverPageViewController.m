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

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle {
    self = [super init];
    if (self) {
        storyFS = aStoryFS;
        title = aBookTitle;
        
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
        UIImage *coverPage = [storyFS getCoverImg: title];
        if (coverPage == nil)  {
            valid = false;
        }
        else {
            valid = true;
            self.backgroundImageView = [[UIImageView alloc]init];
            [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
            [self.backgroundImageView setImage:coverPage];
            [self.view addSubview:self.backgroundImageView];
            [self addReadToMeButton];
            [self addReadByMyselfButton];
            [self addHomeButton];
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

/*!
 * @function addReadToMeButton
 * @abstract adding an read to me button in the view 
 * @discussion It creates button that let user listen to the audio
 */
- (void) addReadToMeButton {
    UIButton *readToMeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.height / 2, 200, 100, 100)];
    UIImage *readToMeImage = [storyFS getReadToMeImg:title];
    
    [readToMeButton setImage:readToMeImage forState:UIControlStateNormal];
    [readToMeButton addTarget:self action:@selector(readToMe) forControlEvents:UIControlEventTouchUpInside];
    //[self.leftButton addTarget:self action:@selector(goToPreviousText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: readToMeButton];
}

/*!
 * @function addReadByMyselfButton
 * @abstract adding an read by myself button in the view
 * @discussion It creates button that let user listen to the audio
 */
- (void) addReadByMyselfButton {
    UIButton *readByMyselfButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.height / 2 + 110, 200, 100, 100)];
    UIImage *readByMyselfImage = [storyFS getReadByMyselfImg:title];
    
    [readByMyselfButton setImage:readByMyselfImage forState:UIControlStateNormal];
    [readByMyselfButton addTarget:self action:@selector(readByMyself) forControlEvents:UIControlEventTouchUpInside];
    //[self.leftButton addTarget:self action:@selector(goToPreviousText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: readByMyselfButton];
}

/*!
 * @function addReadToMe
 * @abstract allow the audio work
 * @discussion allow the audio work
 */
-(void) readToMe
{
    //StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS: storyFS andTitle: title];
    //[aNewBook setReadToMe:true];
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:true];
    [aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];
}
/*!
 * @function addReadByMyself
 * @abstract don't allow the audio work
 * @discussion don't allow the audio work
 */
-(void) readByMyself
{
    //StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS: storyFS andTitle: title];
    //[aNewBook setReadToMe:false];
    
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:false];
    [aNewBook.view setFrame: self.view.bounds];
    [self presentViewController:aNewBook animated:YES completion:nil];
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
 * @function addHomeButton
 * @abstract adding an exit button in the view so user can go back to bookshelf
 * @discussion It creates button that exit current book and redirect to the bookshelf
 */
- (void) addHomeButton {
    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    
    UIImage *homeImg = [storyFS getHomeImg:title];
    
    [homeButton setImage:homeImg forState:UIControlStateNormal];
    
    
    [homeButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: homeButton];
}

/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
