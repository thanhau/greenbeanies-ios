//
//  VocabularyViewController.m
//  SignMeStory
//
//  Created by Thanh Au on 10/4/13.
//  Copyright (c) 2013 Thanh Au. All rights reserved.
//

#import "VocabularyViewController.h"

@interface VocabularyViewController ()

@end

@implementation VocabularyViewController

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
- (void)viewDidAppear:(BOOL)animated
{
    [mpc.view removeFromSuperview];
    mpc = nil;
    self.navigationController.topViewController.title = bookTitle;
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
    if ([listOfVocabulary count] > 0) {
        return [listOfVocabulary count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    NSMutableDictionary *tempDict = [listOfVocabulary objectAtIndex:indexPath.row];
    NSArray *tempArray = [tempDict allKeys];
    //NSLog(@"%i",[tempArray count]);
    NSString *word = tempArray[0];
    cell.textLabel.text = [word uppercaseString];
    cell.textLabel.textColor = [UIColor greenColor];
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
    NSMutableDictionary *tempDict = [listOfVocabulary objectAtIndex:indexPath.row];
    
    NSArray *tempArray = [tempDict allKeys];
    
    NSString *temp = [tempDict objectForKey:tempArray[0]];
    NSURL *urlVideo =  [NSURL URLWithString:temp];
    mpc = [[MPMoviePlayerController alloc]initWithContentURL:urlVideo];
    
    [mpc setMovieSourceType:MPMovieSourceTypeFile];
    [[self view] addSubview:mpc.view];
    [mpc setFullscreen:YES];

    urlVideo = nil;

    

}
- (void) initWithData: (NSString *) data bookTitle:(NSString*) title
{
    listOfVocabulary = [[NSMutableArray alloc]init];
    bookTitle = title;
    
    data = [data stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    

    NSArray *tempArray = [data componentsSeparatedByString:@";"];
    NSLog(@"spit count =%i",[tempArray count]);
    for (int j = 0; j < [tempArray count]; j++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
        NSString *temp1 = tempArray[j];
        temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *component = [temp1 componentsSeparatedByString:@"-"];
        //NSLog(@"%@",component[1]);
        [tempDict setObject:component[1] forKey:component[0]];
        temp1 = nil;
        component = nil;
        [listOfVocabulary addObject:tempDict];
    }
    
    /*
    for (int j = 0; j < [tempArray count]; j++) {
        //NSLog(@"each = %@",tempArray[j]);
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        NSString *temp1 = tempArray[j];
        temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        temp1 = [temp1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *component = [temp1 componentsSeparatedByString:@"-"];
        
        [tempDict setObject:component[1] forKey:component[0]];
        temp1 = nil;
        component = nil;
        [listOfVocabulary addObject:tempDict];
    }
    NSLog(@"%@",listOfVocabulary);
    */

}

@end
