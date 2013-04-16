//
//  ViewController.m
//  MotoriekApp
//
//  Created by David van de Vondervoort on 15-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@end

@implementation ViewController

- (CMMotionManager *)motionManager {
    
    CMMotionManager *motionManager = nil;
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void) startMotionUpdates {
    CMMotionManager *motionManager = [self motionManager];
    
    [motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        NSLog(@"%f", accelerometerData.acceleration.x);
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect movingRect = self.movingView.frame;
            
            movingRect.origin.x += accelerometerData.acceleration.x *15;
            movingRect.origin.y -= accelerometerData.acceleration.y *15;
            
            /*if (CGRectContainsRect(self.view.bounds, movingRect)) {
                self.view.backgroundColor = [UIColor whiteColor];
            } else {
                self.view.backgroundColor = [UIColor redColor];
            }*/
            
            self.movingView.frame = movingRect;
        });
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self startMotionUpdates]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startMotionDetection:(id)sender {
    NSLog(@"startMotionDetection");
    [self startMotionUpdates]; 
}

- (IBAction)stopMotionDetection:(id)sender {
    NSLog(@"stopMotionDetection");
    [[self motionManager] stopAccelerometerUpdates];
}
@end

