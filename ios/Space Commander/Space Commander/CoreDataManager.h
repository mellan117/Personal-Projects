//
//  CoreDataManager.h
//  Space-Commander
//
//  Created by Adam Mellan on 1/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CoreDataManager : NSObject {
    
}
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(id)shared;

-(void)saveMoc; // save context into store
-(NSURL *)storeDirectory; // url to store

@end
