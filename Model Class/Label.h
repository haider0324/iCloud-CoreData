//
//  Label.h
//  MusicRecord
//
//  Created by Haider Abbas on 12/04/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Label : NSManagedObject

@property (nonatomic, retain) NSDate * founded;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *artists;
@end

@interface Label (CoreDataGeneratedAccessors)

- (void)addArtistsObject:(NSManagedObject *)value;
- (void)removeArtistsObject:(NSManagedObject *)value;
- (void)addArtists:(NSSet *)values;
- (void)removeArtists:(NSSet *)values;

@end
