//
//  Exercise.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 24-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MotionLog;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSDate * datetime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * apiNumber;
@property (nonatomic, retain) NSSet *motionLog;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addMotionLogObject:(MotionLog *)value;
- (void)removeMotionLogObject:(MotionLog *)value;
- (void)addMotionLog:(NSSet *)values;
- (void)removeMotionLog:(NSSet *)values;

@end
