//
//  BookshelfViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "BookshelfViewController.h"
#import "IAPProductsHelper.h"
#import <StoreKit/StoreKit.h>

@interface BookshelfViewController ()
{
    int bookId;
    MPMoviePlayerController *mpc;
    NSArray *_products;
}
@end

@implementation BookshelfViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
    /*
    if (bookId == 1)
    {
        
        bookId = 0;
    NSString *stringVideoPath = [[NSBundle mainBundle]pathForResource:@"Signmeastoryopeningscreen" ofType:@"m4v" inDirectory:@"Dictionary"];
    NSURL *urlVideo = [[NSURL alloc] initFileURLWithPath:stringVideoPath];
    
    //NSLog(@"stringpath =%@",stringVideoPath);
    mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
    mpc.controlStyle = MPMovieControlStyleNone;
    [mpc.view setFrame:self.view.bounds];
    [[self view]addSubview:mpc.view];
    [mpc setFullscreen:YES];
    
    [mpc play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    }
    */
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            //[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];

}

- (void)restoreTapped:(id)sender {
    [[IAPProductsHelper sharedInstance] restoreCompletedTransactions];
}

- (void)reload {
    _products = nil;
    //[self.tableView reloadData];
    [[IAPProductsHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            //[self.tableView reloadData];
        }
        //[self.refreshControl endRefreshing];
    }];
}

- (void)buyButtonTapped:(id)sender {
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];

    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[IAPProductsHelper sharedInstance] buyProduct:product];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self reload];
    //Default to first book
    bookId = 1;
    aStoryFS = [[SignMeStoryFS alloc] initFS];
    inventory = [aStoryFS generateBookPaths];
    self.coverViewControllers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [inventory count]; i++) {
        CoverPageViewController *aNewBook = [[CoverPageViewController alloc] initWithStoryBooksFS:aStoryFS andTitle: [NSString stringWithFormat: @"%@", [inventory objectAtIndex:i]]];
        [aNewBook.view setFrame: self.view.bounds];
        [self.coverViewControllers addObject:aNewBook];
    }
    float x_percent = 1;
    float y_percent = 1;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setFloat:x_percent forKey:X_Percentage];
    [userDefault setFloat:y_percent forKey:Y_Percentage];
    // First page orientation issue
    // Remove this line of code will cause the first initial page's size (460, 320) different than we expected (480, 300).
    // Because the first page of the book is initialized in protratait, it deduct the width in landscape by the size of status bar.
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
    
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
    UIImageView *shelfImg = [[UIImageView alloc]init];
    CGSize initialShelfImg = CGSizeMake(320, 460);
    float x_percent = 1;
    float y_percent = 1;
    
    //int width  = 110;
    //int height = 65;
    if (self.view.bounds.size.height != initialShelfImg.height || self.view.bounds.size.width != initialShelfImg.width) {
        x_percent = self.view.bounds.size.width / initialShelfImg.width;
        y_percent = self.view.bounds.size.height / initialShelfImg.height;
        initialShelfImg.width *= x_percent;
        initialShelfImg.height *= y_percent;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setFloat:x_percent forKey:X_Percentage];
    [userDefault setFloat:y_percent forKey:Y_Percentage];
    
    [shelfImg setFrame: CGRectMake(0, 0, initialShelfImg.width, initialShelfImg.height)];
    [shelfImg setImage: [aStoryFS getBookShelfBackground]];
    [shelfImg setUserInteractionEnabled:TRUE];
    
    int numberOfBooks = [self.coverViewControllers count];
    float x_space = 20 * x_percent;
    float y_space = 17 * y_percent;
    float book_w = 120 * x_percent;
    float book_h = 70 * y_percent;
    float x_pos = 0;
    float y_pos = 33 * y_percent;
    
    for (int i = 0; i < numberOfBooks; i++) {
        x_pos += x_space;
        UIButton *bookButton = [[UIButton alloc] initWithFrame:CGRectMake(x_pos, y_pos, book_w, book_h)];
        x_pos += (book_w + x_space);
        [bookButton setTitle:[NSString stringWithFormat: @"%@", [inventory objectAtIndex:i]] forState:UIControlStateNormal];
        UIImage *coverIconForBook = [aStoryFS getCoverIconForBook:[NSString stringWithFormat: @"%@", [inventory objectAtIndex:i]]];
        UIImageView *bookBackgroundView = [[UIImageView alloc] initWithImage:coverIconForBook];
        
        [bookBackgroundView setFrame: CGRectMake(0, 0, book_w, book_h)];
        [bookButton addSubview:bookBackgroundView];
        [bookButton setImage:coverIconForBook forState:UIControlStateNormal];
        
        if (x_pos + book_w + x_space >= self.view.frame.size.width) {
            x_pos = 0;
            y_pos += (book_h + y_space);
        }
        
        // when a book is selected it calls goToBook to switch the view controller.
        if ([[self.coverViewControllers objectAtIndex:i ] isAValidBook]) {
            if (i == 0)
            	[bookButton addTarget:self action:@selector(goToBook:) forControlEvents:UIControlEventTouchUpInside];
            else {
                SKProduct * product = (SKProduct *) _products[i - 1];
                if ([[IAPProductsHelper sharedInstance] productPurchased:product.productIdentifier]) {
                    [bookButton addTarget:self action:@selector(goToBook:) forControlEvents:UIControlEventTouchUpInside];
                } else {
                    bookButton.alpha = 0.5;
                    bookButton.tag = i - 1;
                    //[bookButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        else {
            bookButton.titleLabel.font = [UIFont systemFontOfSize:15 * x_percent];
            [bookButton setTitle:@"Coming Soon!" forState:UIControlStateNormal];
            [bookButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
        [shelfImg addSubview:bookButton];
    }
    //shelfImg = nil;
    
    return shelfImg;
}

/*!
 * @function goToBook
 * @abstract Switch view controller to present
 * @discussion It presents the book's view controller.
 * @param sender
 *    The button representing a book.
 */
- (void) goToBook:(UIButton *) sender {
    
    bookId = [[[sender titleLabel] text] integerValue];
    bookId = bookId - 1;
    
    [[self.coverViewControllers objectAtIndex:bookId] setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:[self.coverViewControllers objectAtIndex:bookId] animated:YES completion:nil];
     
         
}


-(void) goToNextView
{
    [[self.coverViewControllers objectAtIndex:1] setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:[self.coverViewControllers objectAtIndex:bookId] animated:YES completion:nil];
}


// force the orientation to portrait
-(NSInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
