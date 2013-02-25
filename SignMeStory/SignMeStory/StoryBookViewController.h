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
    SignMeStoryFS *storyFS;
    NSString *bookTitle;
    NSString *bookPath;
    int nPages;
    bool valid;
}

@property (nonatomic, retain) NSString *bookTitle;
@property (nonatomic, strong) NSMutableArray *pageText;
@property (nonatomic, retain) NSString *bookPath;
@property (nonatomic, retain) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *pageNumber;
@property (nonatomic, strong) NSMutableArray *listOfBackgroundImageName;
@property (nonatomic, strong) NSMutableArray *listOfStoryText;
@property (nonatomic, strong) NSMutableArray *listOfNameForAllPage;
@property (nonatomic, strong) NSMutableArray *listOfBackgroundImage;
@property (nonatomic, strong) NSMutableArray *listOfAllAnimation;
@property (nonatomic, strong) NSMutableArray *listOfAnimation;
@property (nonatomic, strong) NSMutableArray *listOfTextForAllPage;
@property (nonatomic, strong) NSMutableArray *listOfAudio;
@property (nonatomic, weak) UITapGestureRecognizer *singeTap;
@property (weak, nonatomic) UIToolbar *toolBar;

- (id) initWithStoryBooksDB: (NSString *)bookTitle;
- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle;

@end
