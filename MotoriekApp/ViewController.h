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

- (IBAction)startMotionDetection:(id)sender;
- (IBAction)stopMotionDetection:(id)sender;

@end
