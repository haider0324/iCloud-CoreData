//
//  MRDataModel.m
//  MusicRecords
//
//  Created by Haider Abbas on 17/04/14.
//  Copyright (c) 2014 Haider Abbas. All rights reserved.
//

#import "MRDataModel.h"

@implementation MRDataModel

#pragma mark Files
NSString *const modelName = @"MRRecords";
NSString *const SQLiteName = @"MRRecords.sqlite";

+(MRDataModel *)shared{
    static MRDataModel *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[MRDataModel alloc] init];
    });
    return shared;
}

#pragma mark Paths

-(NSString *)applicationDocumentsDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL *)applicationStoresDirectory{
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL :storesDirectory
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:&error]) {
            NSLog(@"Successfully Created Store Directory");
        }
        else{
            NSLog(@"Directory Not Created");
        }
    }
    return storesDirectory;
}

-(NSURL *)storeURL{
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:SQLiteName];
}

#pragma mark SetUp

-(id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    
    if (_coordinator != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(persistentStoreDidImportContent:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:_coordinator];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(persistentStoresWillChange:) name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:_coordinator];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(persistentStoresDidChange:) name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:_coordinator];
    }
    
    return self;
}

-(void)loadStore{
    if (_store) {
        return;
    }
    
    NSDictionary *options = @{NSPersistentStoreUbiquitousContentNameKey:@"Store"};
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeURL]
                                              options:options
                                                error:&error];
    
    if (!_store) {
        NSLog(@"Failed to add store. Error : %@",error);
        abort();
    }
    else{
        NSLog(@"Succesfully addede store %@",_store);
    }
}

- (void)setupCoreData{
    [self loadStore];
}

#pragma mark Saving

- (void)saveContext{
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persistent store");
        }
        else {
            NSLog(@"Failed to save _context: %@", error);
        }
    }
    else{
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

#pragma mark - Notification

-(void)persistentStoreDidImportContent:(NSNotification *)notification{
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"Error while trying to save data before store will change - %@",error.localizedDescription);
        }
    }
    [_context reset];
}

-(void)persistentStoresWillChange:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PERSISTENT_STORE_CHANGED" object:nil];
}

-(void)persistentStoresDidChange:(NSNotification *)notification{
    [_context mergeChangesFromContextDidSaveNotification:notification];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PERSISTENT_STORE_UPDATED" object:nil];
}

#pragma mark Database Query

- (void)insertDataForAnArtist:(NSMutableDictionary *)dic{
    NSManagedObjectContext *context = self.context;
    Label *label = [NSEntityDescription insertNewObjectForEntityForName:@"Label" inManagedObjectContext:context];
    label.name = [dic objectForKey:LabelName];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSDate *dateFounded = [dateFormatter dateFromString:[dic objectForKey:LabelFounded]];
    label.founded = dateFounded;
    label.genre = [dic objectForKey:LabelGenre];
    
    Artist *art = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    art.artistname = [dic objectForKey:ArtistName];
    art.hometown = [dic objectForKey:ArtistHometown];
    
    Album *alb = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    alb.title = [dic objectForKey:AlbumTitle];
    alb.released = [dateFormatter dateFromString:[dic objectForKey:AlbumReleased]];
    
    [label addArtistsObject:art];
    [art setLabel:label];
    [art addAlbumObject:alb];
    [alb setArtist:art];
    
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful");
    }
    else{
        NSLog(@"The save wasn’t successful: %@", [error userInfo]);
    }
}

- (NSMutableArray *)fetchAlbumRecords{
    NSMutableArray *arrAlbums = [NSMutableArray array];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Label"];
    NSError *error = nil;
    NSArray *fetchedArray = [_context executeFetchRequest:fetchRequest error:&error];
    for (Label *label in fetchedArray) {
        [arrAlbums addObject:label.name];
    }
    return arrAlbums;
}


@end
