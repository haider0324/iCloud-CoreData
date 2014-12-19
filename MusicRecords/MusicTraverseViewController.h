//
//  MusicTraverseViewController.h
//  MusicRecords
//
//  Created by Haider Abbas on 31/03/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTraverseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSMutableArray *arrayData;

@end
