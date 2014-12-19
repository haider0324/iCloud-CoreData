//
//  MusicViewController.h
//  MusicRecords
//
//  Created by Haider Abbas on 31/03/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicViewController : UIViewController<UITextFieldDelegate>{
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtGenre;
@property (strong, nonatomic) IBOutlet UITextField *txtFounded;
@property (strong, nonatomic) IBOutlet UITextField *txtArtistName;
@property (strong, nonatomic) IBOutlet UITextField *txtHometown;
@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtReleased;

@end
