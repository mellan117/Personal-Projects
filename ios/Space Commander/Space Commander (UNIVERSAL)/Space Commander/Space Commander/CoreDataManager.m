//
//  CoreDataManager.m
//  Space-Commander
//
//  Created by Adam Mellan on 1/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>


@implementation CoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(id)shared {
    static id shared=nil;
    if (shared == nil) {
        shared=[[self alloc] init];
    }
    return shared;
}

#pragma mark -
#pragma mark External Services

- (void)saveMoc
{
    NSError *error = nil;
    if (self.managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSURL *)storeDirectory {
    // applications document directory
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark Getters

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil){
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Space-Commander" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self storeDirectory] URLByAppendingPathComponent:@"Space-Commander.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) return _managedObjectContext;
    
    if (self.persistentStoreCoordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

@end
