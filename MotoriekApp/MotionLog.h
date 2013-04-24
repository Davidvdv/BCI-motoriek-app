//
//  MotionLog.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 24-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface MotionLog : NSManagedObject

@property (nonatomic, retain) NSNumber * pitch;
@property (nonatomic, retain) NSNumber * roll;
@property (nonatomic, retain) NSNumber * yaw;
@property (nonatomic, retain) NSNumber * gyroX;
@property (nonatomic, retain) NSNumber * gyroY;
@property (nonatomic, retain) NSNumber * gyroZ;
@property (nonatomic, retain) NSNumber * accelX;
@property (nonatomic, retain) NSNumber * accelY;
@property (nonatomic, retain) NSNumber * accelZ;
@property (nonatomic, retain) Exercise *exercise;

@end
