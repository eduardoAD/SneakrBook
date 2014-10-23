//
//  Person.h
//  SneakrBook
//
//  Created by Eduardo Alvarado Díaz on 10/23/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shoe;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSSet *shoes;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addShoesObject:(Shoe *)value;
- (void)removeShoesObject:(Shoe *)value;
- (void)addShoes:(NSSet *)values;
- (void)removeShoes:(NSSet *)values;

@end
