//
//  MRDataModel.h
//  MusicRecords
//
//  Created by Haider Abbas on 17/04/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Label.h"
#import "Artist.h"
#import "Album.h"

@interface MRDataModel : NSObject

@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;

+(MRDataModel *)shared;

- (void)setupCoreData;
- (void)saveContext;

- (void)insertDataForAnArtist:(NSMutableDictionary *)dic;
- (NSMutableArray *)fetchAlbumRecords;

@end
