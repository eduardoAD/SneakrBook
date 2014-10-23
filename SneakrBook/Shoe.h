//
//  Shoe.h
//  SneakrBook
//
//  Created by Eduardo Alvarado Díaz on 10/23/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Shoe : NSManagedObject

@property (nonatomic, retain) NSString * shoeColor;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) Person *person;

@end
