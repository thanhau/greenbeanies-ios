//
//  BookshelfViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParentalGate/PGView.h>
#import "CoverPageViewController.h"
@class CoverPageViewController;
@interface BookshelfViewController : UIViewController <ParentalLockSuccessDelegate> {
    SignMeStoryFS *aStoryFS;
    NSMutableArray *inventory;
}

@property (nonatomic, strong, retain) NSMutableArray *coverViewControllers;
@property (nonatomic, strong, retain) CoverPageViewController *coverPage;

@end
