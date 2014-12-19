//
//  MusicTraverseViewController.m
//  MusicRecords
//
//  Created by Haider Abbas on 31/03/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import "MusicTraverseViewController.h"

@interface MusicTraverseViewController ()

@end

@implementation MusicTraverseViewController

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
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.arrayData = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(persistentStoreUpdated:) name:@"PERSISTENT_STORE_UPDATED" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(persistentStoreChanged:) name:@"PERSISTENT_STORE_CHANGED" object:nil];
    self.arrayData = [[MRDataModel shared] fetchAlbumRecords];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)persistentStoreUpdated:(NSNotification *)notification{
    self.arrayData = [[MRDataModel shared] fetchAlbumRecords];
    [self.myTable reloadData];
}

-(void)persistentStoreChanged:(NSNotification *)notification{
    self.arrayData = [[MRDataModel shared] fetchAlbumRecords];
    [self.myTable reloadData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self.arrayData objectAtIndex:indexPath.row];
    return cell;
}


@end
