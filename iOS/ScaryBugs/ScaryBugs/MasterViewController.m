//
//  MasterViewController.m
//  ScaryBugs
//
//  Created by Brian G. Butterfield on 11/19/12.
//  Copyright (c) 2012 Brian G. Butterfield. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "ScaryBugData.h"
#import "ScaryBugImage.h"

@interface MasterViewController ()
{
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize bugs = _bugs;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addTapped:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Scary Bugs";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTapped:(id)sender
{
    
    //add bug image
    ScaryBugImage *newBugImage = [[ScaryBugImage alloc] initWithTitle:@"New Bug"
                                                        rating:0
                                                        thumbImage:nil
                                                        fullImage:nil];
    [_bugs addObject:newBugImage];
    
    
    //select the row from the table view
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bugs.count - 1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES
                                                   scrollPosition:UITableViewScrollPositionMiddle];
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bugs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBasicCell"];
    
    ScaryBugImage *bug = [self.bugs objectAtIndex:indexPath.row];
    cell.textLabel.text = bug.data.title;
    cell.imageView.image = bug.thumbImage;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                           forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //remove it from the data model
        [_bugs removeObjectAtIndex:indexPath.row];
        
        //notify the table view a row is being deleted
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                   withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        ScaryBugImage *bug = [self.bugs objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:bug];
    }
}

@end
