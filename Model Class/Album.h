//
//  Album.h
//  MusicRecord
//
//  Created by Haider Abbas on 12/04/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSDate * released;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Artist *artist;

@end
