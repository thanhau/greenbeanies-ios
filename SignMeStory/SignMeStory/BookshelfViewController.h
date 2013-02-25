//
//  BookshelfViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "StoryBookViewController.h"
#import "CoverPageViewController.h"

@interface BookshelfViewController : UIViewController {
    SignMeStoryFS *aStoryFS;
    NSMutableArray *inventory;
}

@property (nonatomic, strong, retain) UIViewController *currentViewController;
@property (nonatomic, strong, retain) NSMutableArray *coverViewControllers;
@property (nonatomic, strong, retain) CoverPageViewController *coverPage;
@end
