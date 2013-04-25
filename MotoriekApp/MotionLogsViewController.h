//
//  MotionLogsViewController.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 25-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MotionLogTableViewCell.h"
#import "MotionLog.h"

@interface MotionLogsViewController : UIViewController <UITableViewDataSource>

@property (strong, nonatomic) NSString *motionsBelongsToExercise;
@property (strong, nonatomic) NSArray *motionLogs;

- (IBAction)dismiss:(id)sender;

@end
