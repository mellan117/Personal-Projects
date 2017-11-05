//
//  Temp.h
//  Space-Commander
//
//  Created by Adam Mellan on 1/31/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Temp : NSManagedObject

@property (nonatomic) int16_t buttonCheck;
@property (nonatomic) int16_t time;
@property (nonatomic) int16_t gold;
@property (nonatomic) BOOL sound;

@end
