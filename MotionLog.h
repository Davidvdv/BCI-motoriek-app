//
//  MotionLog.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 23-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface MotionLog : NSManagedObject

@property (nonatomic, retain) NSNumber * pitch;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * roll;
@property (nonatomic, retain) NSNumber * yaw;
@property (nonatomic, retain) Exercise *exercise;

@end
