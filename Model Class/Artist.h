//
//  Artist.h
//  MusicRecord
//
//  Created by Haider Abbas on 12/04/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Label;

@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * artistname;
@property (nonatomic, retain) NSString * hometown;
@property (nonatomic, retain) Label *label;
@property (nonatomic, retain) NSSet *album;
@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addAlbumObject:(NSManagedObject *)value;
- (void)removeAlbumObject:(NSManagedObject *)value;
- (void)addAlbum:(NSSet *)values;
- (void)removeAlbum:(NSSet *)values;

@end
