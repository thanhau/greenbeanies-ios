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
        storyFS = aStoryFS;
        title = aBookTitle;
        
        UIImage *coverPage = [storyFS getCoverImg: title];
        if (coverPage == nil)  {
            valid = false;
        }
        else {
            valid = true;
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            x_percent = [[userDefault objectForKey:X_Percentage] floatValue];
            y_percent = [[userDefault objectForKey:Y_Percentage] floatValue];
            
            self.backgroundImageView = [[UIImageView alloc]init];
            [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
            [self.backgroundImageView setImage:coverPage];
            [self.view addSubview:self.backgroundImageView];
            [self addReadToMeButton];
            [self addReadByMyselfButton];
            [self addBookShelfButton];
            
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
    UIButton *readToMeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 2 - 60,
                                                                          self.backgroundImageView.frame.size.height - 100,
                                                                          100,
                                                                          100)];
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
    UIButton *readByMyselfButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 2 + 40,
                                                                              self.backgroundImageView.frame.size.height - 100,
                                                                              100,
                                                                              100)];
    UIImage *readByMyselfImage = [storyFS getReadByMyselfImg:title];
    
    [readByMyselfButton setImage:readByMyselfImage forState:UIControlStateNormal];
    [readByMyselfButton addTarget:self action:@selector(readByMyself) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: readByMyselfButton];
}

/*!
 * @function addReadToMe
 * @abstract allow the audio work
 * @discussion allow the audio work
 */
-(void) readToMe
{
    
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:true];
    [aNewBook setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
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
    
    
    StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS:storyFS andTitle:title andWithSound:false];
    [aNewBook setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
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
 * @function addBookShelfButton
 * @abstract adding an exit button in the view so user can go back to bookshelf
 * @discussion It creates button that exit current book and redirect to the bookshelf
 */
- (void) addBookShelfButton {
    UIButton *bookShelfButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
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

@end
