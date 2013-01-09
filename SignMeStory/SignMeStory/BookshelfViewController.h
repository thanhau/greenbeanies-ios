//
//  BookshelfViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryBookViewController.h"

@interface BookshelfViewController : UIViewController

@property (nonatomic, strong, retain) UIViewController *currentViewController;
@property (nonatomic, strong, retain) NSMutableArray *bookViewControllers;

@end
