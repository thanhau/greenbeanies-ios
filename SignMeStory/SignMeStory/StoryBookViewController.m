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
@synthesize bookPath;
@synthesize bookTitle;

<<<<<<< HEAD
/*!
 * @function initWithStoryBooksDB
 * @abstract custom override initialization method
 * @discussion It initialize all the instance and creates pages for this book.
 * @return this view controller
 */
- (id) initWithStoryBooksDB: (NSString *) aBookTitle{
    
    
=======
- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle{
>>>>>>> Update FS
    self = [super init];
    self.bookTitle = aBookTitle;
    self.pageText = [[NSMutableArray alloc] init];
<<<<<<< HEAD
    self.listOfAudio = [[NSMutableArray alloc] init];
    
    
    [self createListOfImage];
    [self createListNameForPage];
    [self createListOfAudio];
    [self createTextPage];
    self.listOfBackgroundImage = [[NSMutableArray alloc] initWithCapacity:[self.listOfBackgroundImageName count]];
    
=======
    self.pageNumber = [[NSMutableArray alloc] init];
>>>>>>> Update FS
    
    storyFS = aStoryFS;
    nPages = [aStoryFS getNumberOfPages:bookTitle];
    [aStoryFS setCurrentBookTitle:aBookTitle];
    
<<<<<<< HEAD
    //self.listOfStoryText = [[NSMutableArray alloc] initWithObjects:@"GreenbeaniesParagraph1.txt",@"GreenbeaniesParagraph2.txt",@"GreenbeaniesParagraph3.txt",@"GreenbeaniesParagraph4.txt", nil];
    //self.listOfStoryText = [[NSMutableArray alloc] initWithObjects:@"GreenbeaniesParagraph1-1.txt",@"GreenbeaniesParagraph2-1.txt", nil];
    
    [self createListOfBackgroundImage];
    
    
=======
    [self initBook];
    
    return self;
}

- (void) initBook{
    // creates text in the book page.
    // this loop should be replace when actuall book pages are implemented
    for (int i = 0; i < nPages; i ++) {        
        [self.pageText addObject:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]];
    }
>>>>>>> Update FS
    
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
    //[self addExitButton];
<<<<<<< HEAD
    
    
    
    
    
    
    
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
 * @function createListOfAnimation
 * @abstract create list of animation
 * @discussion It creates a list of animation
 */
-(void)createListOfImage
{
    NSArray *listNameOfImage = [[NSArray alloc] initWithObjects:@"CityView",@"WeirdLooks",@"StreetZoomed",@"CityView",@"HernyWalkingToCeCe", @"PuttingHatOn",@"SparklingHat",@"PickingUpBackbacks",@"CatJumping",@"BusStopWaiting",@"BusMotion",@"BusStopLeaving" ,@"BoatOnWater",@"BoatOnWater", @"MatildaWorried", @"BoatLeavin", @"DockPicnic", @"Path", @"Wounderland",@"Wounderland",@"Wounder", @"PineNeedleForrest", @"CrossRoad", @"Campsite", @"Campsite(about2sleep)", @"Campsite(sleeping)",nil];
    NSLog(@"Count of listNameOfImage is %i",[listNameOfImage count]);
    
    
    NSArray *numberOfImageForEachPage = [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:9],[NSNumber numberWithInt:4],[NSNumber numberWithInt:3], [NSNumber numberWithInt:9],[NSNumber numberWithInt:8],[NSNumber numberWithInt:13],[NSNumber numberWithInt:3],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:11],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:4],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:1],
                                         [NSNumber numberWithInt:2],nil];
    
    NSLog(@"Count of listImageForEachPag is %i",[numberOfImageForEachPage count]);
    
    for (int y = 0; y < [listNameOfImage count]; y++) {
        NSMutableArray *listImage = [[NSMutableArray alloc] initWithCapacity:[[numberOfImageForEachPage objectAtIndex:0] integerValue]];
        if ([[numberOfImageForEachPage objectAtIndex:y] integerValue] == 1)
        {
            NSString *imgageName = [NSString stringWithFormat:@"%@.jpg",[listNameOfImage objectAtIndex:y]];
            UIImage *img = [UIImage imageNamed:imgageName];
            [listImage addObject:img];
        }
        else
        {
            for (int i = 1; i <= [[numberOfImageForEachPage objectAtIndex:y] integerValue]; i++)
            {
                
                NSString *imgageName = [NSString stringWithFormat:@"%@%i.jpg",[listNameOfImage objectAtIndex:y],i];
                
                UIImage *img = [UIImage imageNamed:imgageName];
                [listImage addObject:img];
                
            }
            
        }
        [self.listOfAllAnimation addObject:listImage];
        
    }
    NSLog(@"Number of animation is %i",[self.listOfAllAnimation count]);
}

/*!
 * @function createListOfAudio
 * @abstract create list of audio
 * @discussion It creates a list of audio
 */
-(void)createListOfAudio
{
    NSMutableArray *arrayOfAudioName1 = [[NSMutableArray alloc]initWithObjects:@"sentence1",@"sentence2",@"sentence3",@"sentence4", nil];
    [self.listOfAudio addObject:arrayOfAudioName1];
    NSMutableArray *arrayOfAudioName2 = [[NSMutableArray alloc] initWithObjects:@"sentence5",@"sentence6",@"sentence7", nil];
    [self.listOfAudio addObject:arrayOfAudioName2];
    NSMutableArray *arrayOfAudioName3 = [[NSMutableArray alloc] initWithObjects:@"sentence8", nil];
    [self.listOfAudio addObject:arrayOfAudioName3];
    [self.listOfAudio addObject:arrayOfAudioName3];
    [self.listOfAudio addObject:arrayOfAudioName3];
    //[self.listOfAudio addObject:arrayOfAudioName3];
    NSLog(@"Number of audio is %i",[self.listOfAudio count]);
}
/*!
 * @function createListNameForPage
 * @abstract create list of name of text for getting content
 * @discussion It creates a list name of text which we get content from
 */
-(void)createListNameForPage
{
    
    NSArray *numberOfTextForEachPage = [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:4],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:9],[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:7],[NSNumber numberWithInt:3],[NSNumber numberWithInt:5],[NSNumber numberWithInt:5],[NSNumber numberWithInt:4], nil];
    
    
    for (int y = 0; y < [numberOfTextForEachPage count]; y++) {
        int numberOfTextForPage = [[numberOfTextForEachPage objectAtIndex:y]intValue];
        NSMutableArray *listOfTextNameForEachPage = [[NSMutableArray alloc]initWithCapacity:numberOfTextForPage];
        for (int i = 1; i <= numberOfTextForPage; i++) {
            NSString *stringName = [NSString stringWithFormat:@"GreenbeaniesParagraph%i-%i.txt",y+1,i];
            [listOfTextNameForEachPage addObject:stringName];
        }
        [self.listOfNameForAllPage addObject:listOfTextNameForEachPage];
    }
    NSLog(@"Number of name is %i",[self.listOfNameForAllPage count]);
}

/*!
 * @function createListOfBackgroundImage
 * @abstract create list of background image
 * @discussion It creates a list of background image
 */
-(void)createListOfBackgroundImage
{
    // create background image in book page.
    for (int i = 0 ; i < [self.listOfBackgroundImageName count]; i++) {
        
        UIImage *img = [UIImage imageNamed:[self.listOfBackgroundImageName objectAtIndex:i]];
        [self.listOfBackgroundImage addObject:img];
    }
}

-(void)createTextPage
{
    // creates text in the book page.
    // this loop should be replace when actuall book pages are implemented
    for (int i = 0; i < [self.listOfNameForAllPage count]; i ++) {
        NSMutableArray *listOfTextForPage = [[NSMutableArray alloc]init];
        //[self.pageText addObject:[NSString stringWithFormat:@"This is page %d for Book %@", i, self.bookTitle ]];
        for (int x = 0; x < [[self.listOfNameForAllPage objectAtIndex:i ] count]; x++) {
            //NSLog(@"%@",[[self.listOfNameForAllPage objectAtIndex:i] objectAtIndex:x]);
            NSURL *url  = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],[[self.listOfNameForAllPage objectAtIndex:i] objectAtIndex:x]]];
            
            NSError *err;
            NSString *contentString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
            //NSLog(@"%@",contentString);
            [listOfTextForPage addObject:contentString];
            //[self.pageText addObject:urlString];
        }
        [self.listOfTextForAllPage addObject:listOfTextForPage];
        
    }
    
    for (int i = 0; i < [self.listOfTextForAllPage count];i++)
    {
        [self.pageText addObject:[[self.listOfTextForAllPage objectAtIndex:i] objectAtIndex:0]];
    }
    NSLog(@"Number of content text is %i",[self.listOfTextForAllPage count]);
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
=======
>>>>>>> Update FS
}

// return the view controller represents the book at the index.
- (BookPageViewController *)bookPageAtIndex: (NSUInteger ) index{
    BookPageViewController *bpVC = [[BookPageViewController alloc] initWithStoryBooksFS:storyFS andPagePath:[self.pageText objectAtIndex:index]];
    [bpVC setPageText:[self.pageText objectAtIndex:index]];
    
    //BookPageViewController *bpVC = [[BookPageViewController alloc] init];
    //[bpVC setPageText:[self.pageText objectAtIndex:index]];
    //[bpVC setAnimationImage:[self.listOfAllAnimation objectAtIndex:index]];
    //[bpVC setListOfText:[self.listOfTextForAllPage objectAtIndex:index]];
    //[bpVC setListOfAudio:[self.listOfAudio objectAtIndex:index]];
    //[bpVC setBackgroundImage:[self.listOfBackgroundImage objectAtIndex:index]];
    
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
    return [self bookPageAtIndex:index];
}

// force the orientation to landscape
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
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
 * @function initWithStoryBooksDB
 * @abstract custom override initialization method
 * @discussion It initialize all the instance and creates pages for this book.
 * @return this view controller
 */
- (id) initWithStoryBooksDB: (NSString *) aBookTitle{
   
    
    self = [super init];
    
    self.listOfAllAnimation = [[NSMutableArray alloc] init];
    self.listOfAnimation = [[NSMutableArray alloc] init];
    self.listOfNameForAllPage = [[NSMutableArray alloc]init];
    self.listOfTextForAllPage = [[NSMutableArray alloc]init];
    self.bookTitle = aBookTitle;
    self.pageText = [[NSMutableArray alloc] init];
    self.listOfAudio = [[NSMutableArray alloc] init];
   
     
    //[self createListOfImage];
    //[self createListNameForPage];
    //[self createListOfAudio];
    //[self createTextPage];
    //[self createListOfBackgroundImage];
    //self.listOfBackgroundImage = [[NSMutableArray alloc] initWithCapacity:[self.listOfBackgroundImageName count]];

    
    //self.listOfBackgroundImageName = [[NSMutableArray alloc] initWithObjects:@"storyboardscreen1.png",@"screen2-1henryandcecewithbackground.png",@"screen3-1background+henryandcece.png",@"storyboard4background.png", nil];
    
    //self.listOfStoryText = [[NSMutableArray alloc] initWithObjects:@"GreenbeaniesParagraph1.txt",@"GreenbeaniesParagraph2.txt",@"GreenbeaniesParagraph3.txt",@"GreenbeaniesParagraph4.txt", nil];
    //self.listOfStoryText = [[NSMutableArray alloc] initWithObjects:@"GreenbeaniesParagraph1-1.txt",@"GreenbeaniesParagraph2-1.txt", nil];
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
    //[self addExitButton];
    
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
