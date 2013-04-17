//
//  ViewController.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 15-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *movingView;
@property (weak, nonatomic) IBOutlet UILabel *XLabel;
@property (weak, nonatomic) IBOutlet UILabel *YLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZLabel;



@property (strong, nonatomic) NSTimer *timer;

- (IBAction)startMotionDetection:(id)sender;
- (IBAction)stopMotionDetection:(id)sender;

@end
