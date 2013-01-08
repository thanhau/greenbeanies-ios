//
//  BookshelfViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "BookshelfViewController.h"

@interface BookshelfViewController ()

@end

@implementation BookshelfViewController

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
    for (int i = 0; i < 10; i++) {
        StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksDB: [NSString stringWithFormat: @"Book %d", i]];
        [aNewBook.view setFrame: self.view.bounds];
        [self addBook: aNewBook];
        [self.bookViewControllers addObject:aNewBook];
        [self addChildViewController: aNewBook];
        [aNewBook didMoveToParentViewController:self];
    }
    
    self.currentViewController = [self.bookViewControllers objectAtIndex:0];
    [self.view addSubview: self.currentViewController.view];
}

- (void) addBook: (StoryBookViewController *) newBook {
    [self.bookViewControllers addObject:newBook];
}


-(void) changeViewController: (int) bookID {
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
