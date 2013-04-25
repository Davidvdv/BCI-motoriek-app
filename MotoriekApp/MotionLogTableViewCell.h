//
//  MotionLogTableViewCell.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 25-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MotionLogTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *XAccelLabel;
@property (weak, nonatomic) IBOutlet UILabel *YAccelLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZAccelLabel;

@property (weak, nonatomic) IBOutlet UILabel *XGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *YGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZGyroLabel;

@property (weak, nonatomic) IBOutlet UILabel *pitchAttitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rollAttitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawAttitudeLabel;

@end
