//
//  StoryBookViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookPageViewController.h"

@interface StoryBookViewController : UIViewController <UIPageViewControllerDataSource, AVAudioPlayerDelegate> {
    NSString *bookTitle;
}
@property (nonatomic, retain) NSString *bookTitle;
@property (nonatomic, retain) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (nonatomic, strong) NSMutableArray *pageText;
@property (nonatomic, strong) NSMutableArray *listOfBackgroundImageName;
@property (nonatomic, strong) NSMutableArray *listOfStoryText;
@property (nonatomic, strong) NSMutableArray *listOfBackgroundImage;
@property (nonatomic, strong) NSMutableArray *listOfAllAnimation;
@property (nonatomic, strong) NSMutableArray *listOfAnimation;
@property (nonatomic, strong) UITapGestureRecognizer *singeTap;

- (id) initWithStoryBooksDB: (NSString *)bookTitle;

@end
