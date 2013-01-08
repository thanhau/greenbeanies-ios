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

- (id) initWithStoryBooksDB: (NSString *)bookTitle;

@end
