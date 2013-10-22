//
//  ListOfBookVocabularyViewController.m
//  SignMeStory
//
//  Created by Thanh Au on 10/3/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "ListOfBookVocabularyViewController.h"

@interface ListOfBookVocabularyViewController ()

@end

@implementation ListOfBookVocabularyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle
{
    self = [super init];
    if (self) {
        UINavigationBar *navBar = self.navigationController.navigationBar;
        /*
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Detail"];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        [UIButton alloc]
        //[button setImage:[UIImage imageNamed:@"plain.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                       initWithCustomView:button];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] in]
        navigationItem.leftBarButtonItem = buttonItem;

        [navBar pushNavigationItem:navigationItem animated:NO];
         */
        storyFS = aStoryFS;
        title = aBookTitle;
        self.listOfBook = [storyFS getListOfVocabulary:title];
        NSLog(@"count = %i",[self.listOfBook count]);
        
        //self.navigationItem.hidesBackButton = YES;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 4, 60, 40)];
        //[button setImage:[UIImage imageNamed:@"leftarrow.png"] forState:UIControlStateNormal];
        [button setTitle:@"Back" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = back;
         
        
    }
    return self;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    if (self.listOfBook != nil) {
        return [self.listOfBook count];

    }
     
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    NSMutableDictionary *tempDict = [self.listOfBook objectAtIndex:indexPath.row];
    NSArray *tempArray = [tempDict allKeys];
    //NSLog(@"%i",[tempArray count]);
    cell.textLabel.text = tempArray[0];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

    NSMutableDictionary *tempDict = [self.listOfBook objectAtIndex:indexPath.row];
    
    NSArray *tempArray = [tempDict allKeys];

    NSString *temp = [tempDict objectForKey:tempArray[0]];
    
    VocabularyViewController *detailView = [[VocabularyViewController alloc]init];
    NSString *bookTitle;
    switch (indexPath.row + 1) {
            case 1:
            	bookTitle = @"GreenBeanies-One Silly Cat";
            	break;
        	case 2:
            	bookTitle = @"GreenBeanies-Two Cool Hat";
            	break;
            default:
            	bookTitle = @"Greenbeanies";
            	break;
    }
    [detailView initWithData:temp bookTitle:bookTitle];
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)backAction {
    
    [self dismissModalViewControllerAnimated:YES];
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"Vocabulary"])
    {
        NSLog(@"test");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       
        

        VocabularyViewController *detailView = (VocabularyViewController *)[segue destinationViewController];
        NSMutableDictionary *tempDict = [self.listOfBook objectAtIndex:indexPath.row];
        NSArray *tempArray = [tempDict allKeys];
        NSString *temp = [tempDict objectForKey:tempArray[0]];
        [detailView initWithData:temp];
        //[detailView populateView:userEmail book:[listOfBook objectAtIndex:indexPath.row]];
        
        
    }
}

*/
@end
