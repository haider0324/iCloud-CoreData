//
//  MusicViewController.m
//  MusicRecords
//
//  Created by Haider Abbas on 31/03/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicTraverseViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

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
    self.navigationItem.title = @"Music Records";
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStyleBordered target:self action:@selector(btnLeftBarClicked:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(btnRightBarClicked:)];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Button Click Events

-(void)btnLeftBarClicked:(id)sender{
    MusicTraverseViewController *musicTraverse = [[MusicTraverseViewController alloc] initWithNibName:@"MusicTraverseViewController" bundle:nil];
    [self.navigationController pushViewController:musicTraverse animated:YES];
}

-(void)btnRightBarClicked:(id)sender{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.txtName.text forKey:LabelName];
    [dic setObject:self.txtGenre.text forKey:LabelGenre];
    [dic setObject:self.txtFounded.text forKey:LabelFounded];
    [dic setObject:self.txtArtistName.text forKey:ArtistName];
    [dic setObject:self.txtHometown.text forKey:ArtistHometown];
    [dic setObject:self.txtTitle.text forKey:AlbumTitle];
    [dic setObject:self.txtReleased.text forKey:AlbumReleased];
    [[MRDataModel shared] insertDataForAnArtist:dic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.txtName]) {
        [self.txtName resignFirstResponder];
    }
    else if ([textField isEqual:self.txtGenre]){
        [self.txtGenre resignFirstResponder];
    }
    else if ([textField isEqual:self.txtFounded]){
        [self.txtFounded resignFirstResponder];
    }
    else if ([textField isEqual:self.txtArtistName]){
        [self.txtArtistName resignFirstResponder];
    }
    else if ([textField isEqual:self.txtHometown]){
        [self.txtHometown resignFirstResponder];
    }
    else if ([textField isEqual:self.txtTitle]){
        [self.txtTitle resignFirstResponder];
    }
    else if ([textField isEqual:self.txtReleased]){
        [self.txtReleased resignFirstResponder];
    }
    return YES;
}

@end
