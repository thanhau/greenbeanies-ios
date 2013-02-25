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

    aStoryFS = [[SignMeStoryFS alloc] initFS];
    inventory = [aStoryFS generateBookPaths];
    self.coverViewControllers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [inventory count]; i++) {
        CoverPageViewController *aNewBook = [[CoverPageViewController alloc] initWithStoryBooksFS:aStoryFS andTitle: [NSString stringWithFormat: @"%@", [inventory objectAtIndex:i]]];
        [aNewBook.view setFrame: self.view.bounds];
        if ([aNewBook isAValidBook]) {
            [self.coverViewControllers addObject:aNewBook];

        }
        //StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksFS: aStoryFS andTitle:[NSString stringWithFormat: @"%@", [inventory objectAtIndex:i]]];
        //[aNewBook.view setFrame: self.view.bounds];
        //if ([aNewBook isAValidBook])
        //    [self.bookViewControllers addObject:aNewBook];
    }
    
    // First page orientation issue
    // Remove this line of code will cause the first initial page's size (460, 320) different than we expected (480, 300).
    // Because the first page of the book is initialized in protratait, it deduct the width in landscape by the size of status bar.
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    
    /*
    self.bookViewControllers = [[NSMutableArray alloc] init];

    // creates 10 testing book.
    // this method should be replace with actual amount of books when testing is completed.
    for (int i = 0; i < 10; i++) {
        StoryBookViewController *aNewBook = [[StoryBookViewController alloc] initWithStoryBooksDB: [NSString stringWithFormat: @"Test %d", i]];
        [aNewBook.view setFrame: self.view.bounds];
        [self.bookViewControllers addObject:aNewBook];
    }
    */
    [self.view addSubview: [self bookShelf]];
}

/*
 We might have to recode this section to accomadate a Collection View
*/
/*!
 * @function bookshelf
 * @abstract Creates a bookshelf view.
 * @discussion It creates a bookshelf-like view containing buttons for every book in the system.
 * @return a bookshelf view.
 */
- (UIView *) bookShelf {
    UIView *shelf = [[UIView alloc] init];
    //Adds the shelf background image
    shelf.backgroundColor = [[UIColor alloc] initWithPatternImage:[aStoryFS getBookShelfBackground]];
    
    [shelf setFrame: self.view.bounds];
    UIColor *c = [[UIColor alloc] initWithRed:.5 green:.5 blue:.5 alpha:.5];
    int x_space = 15;
    int y_space = 17;
    int book_w = 50;
    int book_h = 65;
    int x_pos = 0;
    int y_pos = 30;
    
    for (int i = 0; i < [self.coverViewControllers count]; i++) {
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
        // when a book is selected it calls goToBook to switch the view controller.
        [bookButton addTarget:self action:@selector(goToBook:) forControlEvents:UIControlEventTouchUpInside];
        [shelf addSubview:bookButton];
    }
    return shelf;
}

/*!
 * @function goToBook
 * @abstract Switch view controller to present
 * @discussion It presents the book's view controller.
 * @param sender
 *    The button representing a book.
 */
- (void) goToBook:(UIButton *) sender {
    int bookID = [[[sender titleLabel] text] integerValue];
    NSLog(@"Book %@ is selected", [[sender titleLabel] text]);
//    CoverPageViewController *coverPage = [[CoverPageViewController alloc]init];
    
    [self presentViewController:[self.coverViewControllers objectAtIndex:bookID] animated:YES completion:nil];
    //[self presentViewController:coverPage animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
