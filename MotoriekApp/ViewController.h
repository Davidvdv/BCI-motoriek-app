//
//  ViewController.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 15-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "MotionLog.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    AVAudioPlayer *audioplayer;
}

@property (weak, nonatomic) IBOutlet UIView *movingView;

@property (weak, nonatomic) IBOutlet UILabel *XAccelLabel;
@property (weak, nonatomic) IBOutlet UILabel *YAccelLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZAccelLabel;

@property (weak, nonatomic) IBOutlet UILabel *XGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *YGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZGyroLabel;

@property (weak, nonatomic) IBOutlet UILabel *pitchAttitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rollAttitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawAttitudeLabel;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *motionLogs;
@property (strong, nonatomic) Exercise *exercise;

@property (weak, nonatomic) IBOutlet UIProgressView *exerciseProgressBar;

- (IBAction)startMotionDetection:(id)sender;
- (IBAction)stopMotionDetection:(id)sender;

@end
