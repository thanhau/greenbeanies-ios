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

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bookViewControllers = [[NSMutableArray alloc] init];

    for (int i = 0; i < 10; i++) {
        StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksDB: [NSString stringWithFormat: @"Test %d", i]];
        [aNewBook.view setFrame: self.view.bounds];
        [self.bookViewControllers addObject:aNewBook];
    }
    [self.view addSubview: [self bookShelf]];
}

/*
 We might have to recode this section to accomadate a Collection View
*/
- (UIView *) bookShelf {
    UIView *shelf = [[UIView alloc] init];
    //Adds the shelf background image
    shelf.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bookshelf.png"]];
    [shelf setFrame: self.view.bounds];
    NSMutableArray *bookButtons = [[NSMutableArray alloc] init];
    UIColor *c = [[UIColor alloc] initWithRed:.5 green:.5 blue:.5 alpha:.5];
    int x_space = 15;
    int y_space = 17;
    int book_w = 50;
    int book_h = 65;
    int x_pos = 0;
    int y_pos = 30;
    
    for (int i = 0; i < [self.bookViewControllers count]; i++) {
        x_pos += x_space;
        UIButton *bookButton = [[UIButton alloc] initWithFrame:CGRectMake(x_pos, y_pos, book_w, book_h)];
        x_pos += (book_w + x_space);
        [bookButton setTitle: [NSString stringWithFormat: @"%d", i]
                    forState: UIControlStateNormal];

        if (x_pos + book_w + x_space >= self.view.frame.size.width) {
            x_pos = 0;
            y_pos += (book_h + y_space);
        }
        
        [bookButton setBackgroundColor: c];
        
        [bookButton addTarget:self action:@selector(goToBook:) forControlEvents:UIControlEventTouchUpInside];
        
        [bookButtons addObject:bookButton];
        [shelf addSubview:bookButton];
    }
    return shelf;
}

- (void) goToBook:(UIButton *) sender {
    int bookID = [[[sender titleLabel] text] integerValue];
    NSLog(@"Book %@ is selected", [[sender titleLabel] text]);

    [self presentViewController:[self.bookViewControllers objectAtIndex:bookID] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
