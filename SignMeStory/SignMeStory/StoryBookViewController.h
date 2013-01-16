//
//  StoryBookViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookPageViewController.h"

@interface StoryBookViewController : UIViewController <UIPageViewControllerDataSource> {
    NSString *bookTitle;
}
@property (nonatomic, retain) NSString *bookTitle;
@property (nonatomic, retain) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *pageText;
@property (nonatomic, strong) NSMutableArray *listOfBackgroundImageName;
@property (nonatomic, strong) NSMutableArray *listOfStoryText;
@property (nonatomic, strong) NSMutableArray *listOfBackgroundImage;

- (id) initWithStoryBooksDB: (NSString *)bookTitle;

@end
