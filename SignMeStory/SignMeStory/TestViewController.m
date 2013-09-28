//
//  TestViewController.m
//  SignMeStory
//
//  Created by Thanh Au on 9/5/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    AVAudioPlayer *theAudio;
    MPMoviePlayerController *mpc;
    int audioShouldPlay;
    BOOL isGoingToNextPage;
    CGRect sceneFrame;
}

@end

@implementation TestViewController
@synthesize pagePath;
@synthesize pageText;
@synthesize backgroundImageView;
@synthesize textBackgroundView;
@synthesize backgroundImage;
@synthesize textView;
//@synthesize animationImage;
@synthesize webView;
@synthesize positionOfText;
@synthesize listOfAudio;
@synthesize backgroundImages;
//@synthesize listOfAllBackgroundImageView;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Do play sound and do animation when view appear
- (void) viewDidAppear:(BOOL)animated {
    /*
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(playAnimation)
                                   userInfo:nil
                                    repeats:NO];
     */
    //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
    
    if (withSound) {
        if (audioShouldPlay == 0){
            [self playAudioAt:positionOfText];
            audioShouldPlay++;
        }
    }
    
    
}

// Stop the audio
- (void) viewDidDisappear:(BOOL)animated {
    if (theAudio != nil) {
        [theAudio stop];
    }
}

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle andWithSound: (bool)hasSound{
    self = [super init];
    self.bookTitle = aBookTitle;
    //self.pageTextArray = [[NSMutableArray alloc] init];
    self.pageNumber = [[NSMutableArray alloc] init];
    //self.listOfAllBackgroundImageView = [[NSMutableArray alloc]init];
    self.listOfAllText = [[NSMutableArray alloc]init];
    self.listOfAllAudio = [[NSMutableArray alloc]init];
    self.listOfAllZoomSpec = [[NSMutableArray alloc]init];
    self.listOfZoomSpec = [[NSMutableArray alloc]init];
    //self.dictOfZoomSpec = [[NSMutableDictionary alloc]init];
    currentPageOfDirectory = 0;
    withSound = hasSound;
    storyFS = aStoryFS;
    nPages = [aStoryFS getNumberOfPages:self.bookTitle];
    [aStoryFS setCurrentBookTitle:aBookTitle];
    sceneFrame = [self getScreenFrameForCurrentOrientation];
    originalRectVisible = CGSizeMake(0, 0);
    newRectVisible = CGSizeMake(0, 0);
    originalZoomScale = 1;
    newZoomScale = 0.5;
    //isGoingToNextPage =TRUE;
    [self initBook];
    
    
    return self;
}

- (void) initBook{
    // creates text in the book page.
    // this loop should be replace when actuall book pages are implemented
    for (int i = 0; i < nPages; i ++) {
        
        //[self.pageTextArray addObject:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]];
        
        //[self.listOfAllBackgroundImageView addObject:[storyFS getPageBackgrounds:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]]];
        
        [self.listOfAllText addObject:[storyFS getListOfText:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]]];
        //[self.listOfAllZoomSpec addObject:[storyFS getListOfZoomSpec:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]]];
        //[self.listOfAllAudio addObject:[storyFS getListOfAudio:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]]];
        /*
        NSMutableArray *pageZoomScaleArray = [storyFS getListOfZoomSpec:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, i+1]];
        
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        if (pageZoomScaleArray != nil) {
            //NSLog(@"scale page count =  %i",[pageZoomScaleArray count]);
            for (int k = 0; k < [pageZoomScaleArray count]; k++) {
                NSString *temp = pageZoomScaleArray[k];
                temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                NSArray *tempArray = [temp componentsSeparatedByString:@";"];
                //NSLog(@"spit count =%i",[tempArray count]);
                for (int j = 0; j < [tempArray count]; j++) {
                    //NSLog(@"each = %@",tempArray[j]);
                    NSString *temp1 = tempArray[j];
                    temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                    temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSArray *component = [temp1 componentsSeparatedByString:@":"];
                    //NSLog(@"%@", component[0]);
                    //NSLog(@"%@", component[1]);
                    [tempDict setObject:component[1] forKey:component[0]];
                }
                [pageZoomScaleArray replaceObjectAtIndex:k withObject:tempDict];
            }
            //NSLog(@"test = %@",pageZoomScaleArray);
            [self.listOfAllZoomSpec addObject:pageZoomScaleArray];
            
        }
        //NSLog(@"text count = %i at position = %i",[self.listOfAllText[i] count],i);
        //NSLog(@"zoom count = %i", [self.listOfAllZoomSpec[i] count]);

        */
    }
    //NSLog(@"dict = %@", self.listOfAllZoomSpec);
    //NSLog(@"number of text = %@",self.listOfAllText);
    //NSLog(@"number of background = %@",self.listOfAllBackgroundImageView);
    [self displayPageWithCurrentLocation:currentPageOfDirectory];
}
- (void) displayPageWithCurrentLocation:(int)currentLocationOfPageDirectory
{
    //NSString *path = [self.pageTextArray objectAtIndex:currentLocationOfPageDirectory];
    audioShouldPlay = 0;
    positionOfText = 0;
    // init backgroundImages
    //[self setBackgroundImages: [storyFS getPageBackgrounds:path]];

    
    
    //[self setBackgroundImages:[self.listOfAllBackgroundImageView objectAtIndex:currentPageOfDirectory]];
    [self setBackgroundImages:[storyFS getPageBackgrounds:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, currentLocationOfPageDirectory+1]]];
    
     
    //[self setListOfText: [storyFS getListOfText:path]];
    [self setListOfText:[self.listOfAllText objectAtIndex:currentPageOfDirectory]];
    
    if (withSound)
    {
        //[self setListOfAudio: [storyFS getListOfAudio:path]];
        [self setListOfAudio:[self.listOfAllAudio objectAtIndex:currentPageOfDirectory]];
    }
    // init background animation and chat bubble
    [self initBackgroundAnimation];
    [self initChatBublle];
    //adding arrow
    
    [self addHomeButton];
    [self addLeftButton];
    [self addRightButton];
    // adding toolbar at bottom
    //[self addToolBar];
    
    self.singeTap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(displayAnimation)];
    
    self.singeTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singeTap];
    
    // adding next page symbol
    [self addNextPButton];
    

    if (currentPageOfDirectory == 0  && positionOfText == 0) {
        self.leftButton.hidden = YES;
    }
    //self.listOfZoomSpec = [self.listOfAllZoomSpec objectAtIndex:currentPageOfDirectory];
    NSMutableArray *pageZoomScaleArray = [storyFS getListOfZoomSpec:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, currentPageOfDirectory+1]];
    NSMutableArray *storeScaleArray = [[NSMutableArray alloc]init];
    //NSLog(@"page = %@",pageZoomScaleArray);
    
    if (pageZoomScaleArray != nil) {
        //NSLog(@"scale page count =  %i",[pageZoomScaleArray count]);
        for (int k = 0; k < [pageZoomScaleArray count]; k++) {
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            NSString *temp = pageZoomScaleArray[k];
            //NSLog(@"tempScale = %@",temp);
            temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            NSArray *tempArray = [temp componentsSeparatedByString:@";"];
            //NSLog(@"spit count =%i",[tempArray count]);
            for (int j = 0; j < [tempArray count]; j++) {
                //NSLog(@"each = %@",tempArray[j]);
                NSString *temp1 = tempArray[j];
                temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSArray *component = [temp1 componentsSeparatedByString:@":"];
                //NSLog(@"%@", component[0]);
                //NSLog(@"%@", component[1]);
                [tempDict setObject:component[1] forKey:component[0]];
            }
            //NSLog(@"temp = %@",tempDict);
            [storeScaleArray addObject:tempDict];
            //[pageZoomScaleArray replaceObjectAtIndex:k withObject:tempDict];
            //NSLog(@"store = %@",storeScaleArray);
        }
        //NSLog(@"test = %@",storeScaleArray);
        self.listOfZoomSpec  = storeScaleArray;
    }
    NSMutableDictionary* tempDir = [self.listOfZoomSpec objectAtIndex:positionOfText];

    originalRectVisible = [self getOriginalRectVisible:tempDir];
    originalZoomScale = [self getOriginalZoomScale:tempDir];
    [self.scrollView scrollRectToVisible:CGRectMake(originalRectVisible.width, originalRectVisible.height, sceneFrame.size.width, sceneFrame.size.height) animated:NO];
    self.scrollView.zoomScale = originalZoomScale;
    tempDir = nil;
}
- (void) changeInfo:(int)currentLocationOfPageDirectory
{
    //NSString *path = [self.pageTextArray objectAtIndex:currentLocationOfPageDirectory];
    audioShouldPlay = 0;
    
    // init backgroundImages
    
    
    //[self setBackgroundImages:[self.listOfAllBackgroundImageView objectAtIndex:currentPageOfDirectory]];
    self.scrollView.zoomScale = .5;
    [self setBackgroundImages:[storyFS getPageBackgrounds:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, currentLocationOfPageDirectory+1]]];
    [self.backgroundImageView setImage: [[self backgroundImages ]objectAtIndex:0]];
    
    [self setListOfText:[self.listOfAllText objectAtIndex:currentPageOfDirectory]];
    self.backgroundImageView.animationImages = nil;
    
    self.backgroundImageView.animationImages = self.backgroundImages;
    if (withSound)
    {
        //[self setListOfAudio: [storyFS getListOfAudio:path]];
        [self setListOfAudio:[self.listOfAllAudio objectAtIndex:currentPageOfDirectory]];
    }
    if (isGoingToNextPage) {
       
        self.positionOfText = 0;
    }
    else {
        
        self.positionOfText = [self.listOfText count] -1;
    }
    
    [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
    
    NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
    if (withSound) {
        [self playAudioAt:self.positionOfText];
    }
    
    
    /*
    if (currentPageOfDirectory == [self.listOfAllText count] - 1 && [self.listOfText count] != 1) {
        NSLog(@"at the end of the page");
        self.rightButton.hidden = NO;
        self.leftButton.hidden = NO;
    }
    */
    if (currentPageOfDirectory < [self.listOfAllText count] -1 && currentPageOfDirectory > 0)
    {
        self.rightButton.hidden = NO;
        self.leftButton.hidden = NO;
    }

    if (currentPageOfDirectory == 0  && positionOfText == 0) {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = NO;
    }
    if ((currentPageOfDirectory == [self.listOfAllText count] - 1) && (positionOfText == [self.listOfText count] - 1) ) {
        //NSLog(@"at the last page");
        self.leftButton.hidden = NO;
        self.rightButton.hidden = YES;
    }

    /*
    self.listOfZoomSpec = [self.listOfAllZoomSpec objectAtIndex:currentPageOfDirectory];
    //NSLog(@"%@",self.listOfZoomSpec);
    //NSLog(@"positon of dir = %i, postion of text = %i",currentPageOfDirectory,positionOfText);
    NSMutableDictionary* tempDir = [self.listOfZoomSpec objectAtIndex:positionOfText];
    
    originalRectVisible = [self getOriginalRectVisible:tempDir];
    originalZoomScale = [self getOriginalZoomScale:tempDir];
    //NSLog(@"current zoom scale = %f",originalZoomScale);
    [self.scrollView scrollRectToVisible:CGRectMake(originalRectVisible.width, originalRectVisible.height, sceneFrame.size.width, sceneFrame.size.height) animated:NO];
    self.scrollView.zoomScale = originalZoomScale;
    
    tempDir = nil;
    NSLog(@"%i",currentPageOfDirectory);
     */
    

    NSMutableArray *pageZoomScaleArray = [storyFS getListOfZoomSpec:[NSString stringWithFormat:@"/%@/%d", self.bookTitle, currentPageOfDirectory+1]];
    NSMutableArray *storeScaleArray = [[NSMutableArray alloc]init];
    //NSLog(@"page = %@",pageZoomScaleArray);
    
    if (pageZoomScaleArray != nil) {
        //NSLog(@"scale page count =  %i",[pageZoomScaleArray count]);
        for (int k = 0; k < [pageZoomScaleArray count]; k++) {
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            NSString *temp = pageZoomScaleArray[k];
            //NSLog(@"tempScale = %@",temp);
            temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            NSArray *tempArray = [temp componentsSeparatedByString:@";"];
            //NSLog(@"spit count =%i",[tempArray count]);
            for (int j = 0; j < [tempArray count]; j++) {
                //NSLog(@"each = %@",tempArray[j]);
                NSString *temp1 = tempArray[j];
                temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSArray *component = [temp1 componentsSeparatedByString:@":"];
                //NSLog(@"%@", component[0]);
                //NSLog(@"%@", component[1]);
                [tempDict setObject:component[1] forKey:component[0]];
            }
            //NSLog(@"temp = %@",tempDict);
            [storeScaleArray addObject:tempDict];
            //[pageZoomScaleArray replaceObjectAtIndex:k withObject:tempDict];
            //NSLog(@"store = %@",storeScaleArray);
        }
        //NSLog(@"test = %@",storeScaleArray);
        self.listOfZoomSpec  = storeScaleArray;
    }
    NSMutableDictionary* tempDir = [self.listOfZoomSpec objectAtIndex:positionOfText];
    originalRectVisible = [self getOriginalRectVisible:tempDir];
    originalZoomScale = [self getOriginalZoomScale:tempDir];
    //NSLog(@"current zoom scale = %f",originalZoomScale);
    [self.scrollView scrollRectToVisible:CGRectMake(originalRectVisible.width, originalRectVisible.height, sceneFrame.size.width, sceneFrame.size.height) animated:NO];
    self.scrollView.zoomScale = originalZoomScale;
    
    tempDir = nil;


}




//Add page curl to background imafe
- (void) addNextPButton {
    self.nextPButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.height - 50,
                                                                  0, 50 , 50)];
    UIImage *bookShelfImg = [storyFS getCurlPageImg];
    
    [self.nextPButton setImage:bookShelfImg forState:UIControlStateNormal];
    [self.nextPButton addTarget:self action:@selector(showNextPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextPButton setHidden:TRUE];
    [self.view addSubview:self.nextPButton];
}

//Initialize the background
- (void) initBackgroundAnimation {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];

    
    self.scrollView.bounces = NO;
    self.scrollView.bouncesZoom = NO;
    self.scrollView.minimumZoomScale = .1;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.delegate = self;
    //self.scrollView.scrollEnabled = NO;
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    CGSize size = CGSizeMake(sceneFrame.size.width * 2, sceneFrame.size.height *2);
    UIImage *temp = [self imageWithImage:[[self backgroundImages ]objectAtIndex:0] convertToSize:size];
    //[self.backgroundImageView setImage: [[self backgroundImages ]objectAtIndex:0]];
    [self.backgroundImageView setImage: temp];
    temp = nil;
    self.scrollView.contentSize = self.backgroundImageView.image.size;
    self.backgroundImageView.frame = CGRectMake(0, 0, self.backgroundImageView.image.size.width, self.backgroundImageView.image.size.height);
    //NSLog(@"%f%f",self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    //NSLog(@"%f%f",self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    if (self.backgroundImages != nil) {
        self.backgroundImageView.animationImages = self.backgroundImages;
        self.backgroundImageView.animationDuration = 1;
        self.backgroundImageView.animationRepeatCount = 1;
    }
    [self.scrollView addSubview:self.backgroundImageView];
    [self.view addSubview:self.scrollView];
    //[self.view addSubview:self.backgroundImageView];
}

//Initialize the chat bubble
- (void) initChatBublle {
    self.textBackgroundView = [[UIImageView alloc]init];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *x_percent = [userDefault objectForKey:X_Percentage];
    
    float x_space = 10 * [x_percent floatValue];
    float y_space = 3;
    
    
    self.webView = [[UIWebView alloc]initWithFrame: CGRectMake(sceneFrame.origin.x + x_space,sceneFrame.origin.y + y_space, sceneFrame.size.width - (x_space * 2), 50)];
    
    NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:0]];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    self.webView.opaque = NO;
    [self.webView setDelegate:self];
    [[self.webView scrollView] setScrollEnabled:false];
    
    [self.view addSubview:self.textBackgroundView];
    [self.view addSubview:self.webView];
}



/*!
 * @function animation
 * @abstract animation
 * @discussion It creates animation from group of imgage
 */
-(void) playAnimation{
    
 
        NSLog(@"Zoom");
        
        //float desiredZoomScale = .5;
        
        //float zooming = fabsf(self.scrollView.zoomScale - desiredZoomScale);
        NSMutableDictionary* tempDir = [self.listOfZoomSpec objectAtIndex:positionOfText];
    
        newRectVisible = [self getNewRectVisible:tempDir];
        newZoomScale = [self getNewZoomScale:tempDir];;
        tempDir = nil;
        float desiredZoomScale = newZoomScale;
        CGRect contentFrame = CGRectMake(newRectVisible.width, newRectVisible.height, sceneFrame.size.width, sceneFrame.size.height);
        //self.backgroundImageView.center  = CGPointMake(461, 177);
        CGRect scrollFrame = [self.backgroundImageView convertRect:contentFrame toView:self.scrollView];
        //scrollFrame = CGRectMake(461, 177, 480, 320);
        NSLog(@"scrollview scale = %f",self.scrollView.zoomScale);
        [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{

            //self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
            //contentFrame = CGRectMake(461, 177, 460, 320);
            /*
            [self.scrollView scrollRectToVisible:scrollFrame animated:NO];
            [self.scrollView setZoomScale:desiredZoomScale animated:NO];
            */
            [self.scrollView scrollRectToVisible:scrollFrame animated:NO];
            [self.scrollView setZoomScale:desiredZoomScale animated:NO];
            /*
            if (originalZoomScale > newZoomScale) {
                [self.scrollView scrollRectToVisible:scrollFrame animated:NO];
                [self.scrollView setZoomScale:desiredZoomScale animated:NO];
            }
            else {
                [self.scrollView scrollRectToVisible:scrollFrame animated:NO];
                [self.scrollView setZoomScale:desiredZoomScale animated:NO];
                [self.scrollView scrollRectToVisible:scrollFrame animated:NO];
            }
            */
            
            
            
            
        } completion:^(BOOL finished)  {
            NSLog(@"scrollview scale = %f",self.scrollView.zoomScale);
            if ([self.backgroundImages count] > 1) {
                if ([self.backgroundImages count] / 10 > 1) {
                    float duration = [self.backgroundImages count] / 10;
                    self.backgroundImageView.animationDuration = duration;
                }
                else
                {
                    self.backgroundImageView.animationDuration = 1;
                }
                self.backgroundImageView.image = [[self backgroundImages ] lastObject];
                
                [self.backgroundImageView startAnimating];
            }
        }];
        /*
        if ([self.backgroundImages count] / 10 > 1) {
            float duration = [self.backgroundImages count] / 10;
            self.backgroundImageView.animationDuration = duration;
        }
        else
        {
            self.backgroundImageView.animationDuration = 1;
        }
        self.backgroundImageView.image = [[self backgroundImages ] lastObject];

        [self.backgroundImageView startAnimating];
         */
    }
    


/*!
 * @function addLeftButton
 * @abstract adding an left button in the view so user can go back to previous text
 * @discussion It creates button that let user go back to previous text
 */
- (void) addLeftButton {
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(sceneFrame.origin.x, sceneFrame.size.height/2, 50, 50)];
    
    UIImage *leftArrow = [storyFS getLeftButtonImg];
    
    [self.leftButton setImage:leftArrow forState:UIControlStateNormal];
    
    
    [self.leftButton addTarget:self action:@selector(goToPreviousText) forControlEvents:UIControlEventTouchUpInside];
    self.singeTap.cancelsTouchesInView = NO;
    //self.leftButton.hidden = YES;
    [self.view addSubview: self.leftButton];
}


/*!
 * @function addRightButton
 * @abstract adding an right button in the view so user can go back to previous text
 * @discussion It creates button that let user go back to previous text
 */
- (void) addRightButton {
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(sceneFrame.size.width - 50, sceneFrame.size.height/2, 50, 50)];
    UIImage *rightArrow = [storyFS getRightButtonImg];
    
    [self.rightButton setImage:rightArrow forState:UIControlStateNormal];
    
    [self.rightButton addTarget:self action:@selector(goToNextText) forControlEvents:UIControlEventTouchUpInside];
    self.singeTap.cancelsTouchesInView = NO;
    [self.view addSubview: self.rightButton];
}

- (void) addHomeButton {
    self.homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width - 44, 44, 44)];
    UIImage *homeIconImg = [storyFS getHomeImg];
    [self.homeButton setImage:homeIconImg forState:UIControlStateNormal];
    [self.homeButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    self.singeTap.cancelsTouchesInView = NO;
    [self.view addSubview: self.homeButton];
}

/*!
 * @function goToNextText
 * @abstract go to next text when user click on right button
 * @discussion It go to next text when user click on right button
 */
-(void)goToNextText {
    self.positionOfText = self.positionOfText + 1;
    
    if (self.positionOfText < [self.listOfText count])
    {
        self.scrollView.zoomScale = 1;
        [self.backgroundImageView setImage: [[self backgroundImages ]objectAtIndex:0]];
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
        
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        if (self.leftButton.hidden == YES)
        {
            self.leftButton.hidden = NO;
        }
        if ((currentPageOfDirectory == [self.listOfAllText count] - 1) && (positionOfText == [self.listOfText count] - 1) ) {
            //self.leftButton.hidden = NO;
            self.rightButton.hidden = YES;
        }
        if (withSound) {
            [self playAudioAt:self.positionOfText];
        }
        NSMutableDictionary* tempDir = [self.listOfZoomSpec objectAtIndex:positionOfText];
        
        originalRectVisible = [self getOriginalRectVisible:tempDir];
        originalZoomScale = [self getOriginalZoomScale:tempDir];
        tempDir = nil;
        [self.scrollView scrollRectToVisible:CGRectMake(originalRectVisible.width, originalRectVisible.height, sceneFrame.size.width, sceneFrame.size.height) animated:NO];
        self.scrollView.zoomScale = originalZoomScale;
        
    }
    else
    {
        currentPageOfDirectory = currentPageOfDirectory + 1;
        if (currentPageOfDirectory < [self.listOfAllText count])
        {
            isGoingToNextPage = YES;
            [self changeInfo:currentPageOfDirectory];
            
        }
    }
}

/*!
 * @function goToPreviousText
 * @abstract go to previous text when user click on left button
 * @discussion It go to previous text when user click on left button
 */
-(void)goToPreviousText {
    self.positionOfText = self.positionOfText - 1;
    self.nextPButton.hidden = YES;
    
    if (self.positionOfText >= 0)
    {
        self.scrollView.zoomScale = 1;
        [self.backgroundImageView setImage: [[self backgroundImages ]objectAtIndex:0]];
        [self.textView setText:[self.listOfText objectAtIndex:self.positionOfText]];
        
        NSString *htmlString = [self createWebString:[self.listOfText objectAtIndex:self.positionOfText] ];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        if (self.rightButton.hidden == YES)
        {
            self.rightButton.hidden = NO;
        }
        if (self.positionOfText == 0 && currentPageOfDirectory == 0)
        {
            
            //[self playAnimation];
            self.leftButton.hidden = YES;
        }
        if (withSound) {
            [self playAudioAt:self.positionOfText];
        }
        NSMutableDictionary* tempDir = [self.listOfZoomSpec objectAtIndex:positionOfText];
        
        originalRectVisible = [self getOriginalRectVisible:tempDir];
        originalZoomScale = [self getOriginalZoomScale:tempDir];
        tempDir = nil;
        [self.scrollView scrollRectToVisible:CGRectMake(originalRectVisible.width, originalRectVisible.height, sceneFrame.size.width, sceneFrame.size.height) animated:NO];
        self.scrollView.zoomScale = originalZoomScale;
    }
    else
    {
        
        
        
        currentPageOfDirectory = currentPageOfDirectory - 1;
        if (currentPageOfDirectory >= 0)
        {
            isGoingToNextPage = NO;
            [self changeInfo:currentPageOfDirectory];
            
        }
    }
}



// play audio at certain index
- (void) playAudioAt:(int) index {
    if (theAudio != nil) {
        [theAudio stop];
    }
    AVAudioPlayer *nextAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[[self listOfAudio] objectAtIndex:index] error:nil];
    theAudio = nextAudio;
    [theAudio prepareToPlay];
    
    float playDelay = .5;
    durationOfAudio = [theAudio duration];
    [theAudio playAtTime:(theAudio.deviceCurrentTime + playDelay)];
}


/*!
 * @function pauseAudio
 * @abstract pause audio for text
 * @discussion pause audio for text
 */
-(void)pauseAudio {
    
    [theAudio pause];
    
}
/*!
 * @function addPlayButton
 * @abstract adding an play audio button in the view so user can play the audio
 * @discussion It creates button that play audio
 */
- (void) addPlayButton {
    UIImage *playImage = [UIImage imageNamed:@"play.png"];
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backgroundImageView.frame.size.width / 2, self.backgroundImageView.frame.size.height - 45, 30, 30)];
    
    [playButton setImage:playImage forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: playButton];
    
}

/*!
 * @function resize the image
 * @abstract resize the image
 * @discussion resize the image
 */
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
/*!
 * @function playAudio
 * @abstract play audio for text
 * @discussion play audio for text
 */
-(void)playAudio
{
    [theAudio play];
    
}



/*!
 * @function playAudio
 * @abstract play audio for text
 * @discussion play audio for text
 */
-(void)stopAudio
{
    [theAudio stop];
    
}
/*!
 * @function showToolBar
 * @abstract show or hide the tool bar
 * @discussion show or hide the tool bar when user click on it
 */
- (void)showToolbar
{
    /*
    if (self.toolBar.hidden == YES) {
        [UIView animateWithDuration:0
                         animations:^(void) {
                             [self.toolBar setAlpha:1];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = NO;
                             [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoHideToolBar) userInfo:nil repeats:NO];
                         }
         ];
        //[self.view bringSubviewToFront:self.toolBar];
        
    }
    else if (self.toolBar.hidden == NO) {
        
        [UIView animateWithDuration:2
                         animations:^(void) {
                             [self.toolBar setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = YES;
                         }
         ];
        
    }
     */
    [self playAnimation];
}

/*!
 * @function displayAnimation
 * @abstract playAnimation
 * @discussion play animation to user when user click on it
 */
- (void)displayAnimation
{
    [self playAnimation];
}


/*!
 * @function auto hide toolbar
 * @abstract auto hide toolbar for control the audio
 * @discussion It hide toolbar automaticly
 */
-(void) autoHideToolBar
{
    if (self.toolBar.hidden == NO) {
        
        [UIView animateWithDuration:1
                         animations:^(void) {
                             [self.toolBar setAlpha:0];
                         }
                         completion:^(BOOL finished) {
                             self.toolBar.hidden = YES;
                         }
         ];
        
    }
    
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
    // make toolbar transparent
    [self.toolBar setBarStyle:UIBarStyleBlack];
    self.toolBar.translucent = YES;
    // init the singe tap gesture
    self.singeTap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showToolbar)];
    
    self.singeTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singeTap];
    self.view.userInteractionEnabled = YES;
    //Canlce interference on click baritembutton
    self.singeTap.cancelsTouchesInView = NO;
    [self.singeTap setDelegate:self];
    [self.view addSubview:self.toolBar];
    //create space to aligment the toolbar item
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //create play button
    UIBarButtonItem *playButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
     target:self
     action:@selector(playAudio)];
    
    //create pause button
    UIBarButtonItem *pauseButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemPause
     target: self
     action:@selector(pauseAudio)];
    
    //create bar button
    UIBarButtonItem *stopButton =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemStop
     target: self
     action:@selector(stopAudio)];
    
    //create quit button
    
    UIImage *homeIconImg = [storyFS getHomeImg];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeIconImg style:UIBarButtonItemStylePlain target:self action:@selector(quit)];
    if (withSound) {
        NSArray *buttons = [[NSArray alloc]
                            initWithObjects:homeButton,flexibleSpace,playButton, pauseButton,stopButton,flexibleSpace, nil];
        self.toolBar.items = buttons;
    }
    else {
        NSArray *buttons = [[NSArray alloc] initWithObjects:homeButton, nil];
        self.toolBar.items = buttons;
    }
    
}


/*!
 * @function quit
 * @abstract quit current view
 * @discussion dismiss current view controller, back to the bookshelf.
 */
-(void) quit
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self removeFromParentViewController];
}

//Tap Gesture won't happen when use click on the left and right arrow
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    
    return ((! [self.leftButton pointInside:[touch locationInView:self.leftButton] withEvent:nil]) && (! [self.rightButton pointInside:[touch locationInView:self.rightButton] withEvent:nil]) && [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]);
}
/*!
 * @function webViewDidFinishLoad
 * @abstract resize the web view after it finishes loading
 * @discussion resize the web view after it finishes loading
 */
- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    [self.textBackgroundView setHidden:TRUE];
    if ([[self.listOfText objectAtIndex:0] isEqualToString:@""]) {
        //[self.webView setFrame:(CGRectMake(0, 0, 0, 0))];
        //[self.textBackgroundView setFrame:(CGRectMake(0, 0, 0, 0))];
        [self.webView setHidden:TRUE];
        [self.textBackgroundView setHidden:TRUE];
    }
    else {
        [self.webView setHidden:FALSE];
        [self.textBackgroundView setHidden:FALSE];
        [self.textBackgroundView setImage:[storyFS getChatBubbleImg]];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        float x_percent = [[userDefault valueForKey:X_Percentage] floatValue];
        
        CGRect frame1 = aWebView.frame;
        frame1.size.height = 1;
        aWebView.frame = frame1;
        CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
        frame1.size = fittingSize;
        aWebView.frame = frame1;
        
        if (fittingSize.height * x_percent >= 40 * x_percent) {
            self.textBackgroundView.frame = CGRectMake(self.webView.frame.origin.x,
                                                       self.webView.frame.origin.y,
                                                       self.webView.frame.size.width,
                                                       fittingSize.height - 15 * x_percent);
        }
        else {
            self.textBackgroundView.frame = CGRectMake(self.webView.frame.origin.x,
                                                       self.webView.frame.origin.y,
                                                       self.webView.frame.size.width,
                                                       fittingSize.height);
        }
        [self.textBackgroundView setHidden:FALSE];
    }
}

/*!
 * @function createWebString
 * @abstract create string of web for content
 * @discussion create string of web for content
 */
-(NSString*)createWebString:(NSString*)content
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    float x_percent = [[userDefault valueForKey:X_Percentage] floatValue];
    
    /*
    NSString* cont = @"";
    NSArray *LISTOFWORD = [[NSArray alloc] initWithObjects:@"hat",@"dog", @"sleep",@"tree",@"happy",@"cat",@"backpack", @"walking",@"sun", @"dream", @"bird", @"butterfly",@"dance",@"hungry", @"thirsty", @"water", @"bee",@"ran",@"smile",@"jumped",@"home",@"finished",@"morning", nil];
    NSArray *com = [content componentsSeparatedByString:@" "];
    NSMutableArray *component = [[NSMutableArray alloc] initWithArray:com];
    for (int i = 0; i < [component count]; i++) {
        for (int j = 0; j < [LISTOFWORD count]; j++) {
            if ([[component[i] lowercaseString] isEqualToString:LISTOFWORD[j]]) {
                    NSString *temp = [NSString stringWithFormat:@"<a type='link' onclick='window.location=\"http://hidevmobile.com/gbv/%@.mp4\"'><i><b><u><FONT COLOR='green'>%@</FONT></b></u></i></a>",LISTOFWORD[j],LISTOFWORD[j]];
                component[i] = temp;
            }
        }
        cont = [cont stringByAppendingString:component[i]];
        cont = [cont stringByAppendingString:@" "];

    }
    NSLog(@"%@",cont);
    */
    
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; text-align:center}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body><p>%@</p></body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:20 * x_percent], content];
    return myDescriptionHTML;
}

//Load video when user click on link
- (BOOL) webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    
    //NSLog(@"%@",[url scheme] );
    if ([[url scheme] isEqualToString:@"http"]) {
        
        NSString *urlString = [[request URL] absoluteString];
        
        NSURL *urlVideo =  [NSURL URLWithString:urlString];
        mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
        
        [mpc setMovieSourceType:MPMovieSourceTypeFile];
        [[self view] addSubview:mpc.view];
        [mpc setFullscreen:YES];
        return NO;
    }
    return YES;
}

- (void) showNextPage {
    /*
     NSLog(@"show Next Page");
     UIViewController *screen = [[UIViewController alloc] init];
     [screen setModalTransitionStyle:UIModalTransitionStylePartialCurl];
     [self presentViewController:screen animated:YES completion:nil];
     */
}

// hide button
-(void) hideButton:(UIButton *)aButton{
    [aButton setHidden:(![aButton isHidden])];
}

// force the orientation to landscape
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
-(void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"bound of scrollview = %f%f", scrollView.bounds.origin.x,scrollView.bounds.origin.y );
    NSLog(@"bound of imageview = %f%f", backgroundImageView.bounds.origin.x,backgroundImageView.bounds.origin.y );
}
-(UIView * )viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.backgroundImageView;
}


- (CGRect)getScreenFrameForCurrentOrientation {
    return [self getScreenFrameForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect fullScreenRect = screen.bounds;
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

- (float) getOriginalZoomScale:(NSMutableDictionary *)dict {
    NSString *temp = [dict objectForKey:@"originalZoomScale"];
    //NSLog(@"scale = %f",[temp floatValue]);
    return  [temp floatValue];
}

- (float) getNewZoomScale:(NSMutableDictionary *)dict {
    NSString *temp = [dict objectForKey:@"newZoomScale"];
    NSLog(@"scale = %f",[temp floatValue]);
    return [temp floatValue];
}

- (CGSize) getOriginalRectVisible:(NSMutableDictionary *)dict {
    NSString *temp = [dict objectForKey:@"originalRectVisible"];
    
    NSArray *tempArr = [temp componentsSeparatedByString:@","];
    float width = [tempArr[0] floatValue ];
    float height = [tempArr[1] floatValue ];
    //NSLog(@"size = %f%f",width,height);
    return CGSizeMake(width, height);
}
- (CGSize) getNewRectVisible:(NSMutableDictionary *)dict {
    NSString *temp = [dict objectForKey:@"newRectVisible"];
    
    NSArray *tempArr = [temp componentsSeparatedByString:@","];
    float width = [tempArr[0] floatValue ];
    float height = [tempArr[1] floatValue ];
    NSLog(@"size = %f%f",width,height);
    return CGSizeMake(width, height);
}
@end
