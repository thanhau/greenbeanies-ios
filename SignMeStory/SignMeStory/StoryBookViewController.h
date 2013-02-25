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
@property (nonatomic, weak) UITapGestureRecognizer *singeTap;
@property (weak, nonatomic) UIToolbar *toolBar;

- (id) initWithStoryBooksDB: (NSString *)bookTitle;
- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle;
- (void) setReadToMe: (bool) onOrOff;

@end
