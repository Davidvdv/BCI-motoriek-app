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
@synthesize timer, XLabel, YLabel, ZLabel;

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
    __block CMAccelerometerData *logMotion;
    
    [motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect movingRect = self.movingView.frame;

//            if (movingRect.origin.x < self.view.frame.size.width && movingRect.origin.x > 0) {
//                movingRect.origin.x += accelerometerData.acceleration.x *15;
//            }
//            
//            if(movingRect.origin.y > 0 && movingRect.origin.y < self.view.frame.origin.y) {
//                 movingRect.origin.y -= accelerometerData.acceleration.y *15;
//            }
            
            movingRect.origin.x += accelerometerData.acceleration.x *15;
            movingRect.origin.y -= accelerometerData.acceleration.y *15;
           
            if (CGRectContainsRect(self.view.bounds, movingRect)) {
                self.view.backgroundColor = [UIColor whiteColor];
            } else {
                self.view.backgroundColor = [UIColor redColor];
            }

            self.movingView.frame = movingRect;
            
            logMotion = accelerometerData;
            
            [XLabel setText:[NSString stringWithFormat:@"%f", accelerometerData.acceleration.x]];
            [YLabel setText:[NSString stringWithFormat:@"%f", accelerometerData.acceleration.y]];
            [ZLabel setText:[NSString stringWithFormat:@"%f", accelerometerData.acceleration.z]];
        });
        
    }];
    
    [motionManager startGyroUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMGyroData *gyroData, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logDataWithAcceleration) userInfo:logMotion repeats:YES];
}

- (void) logDataWithAcceleration {
    NSLog(@"logDataWithAcceleration");
    CMAccelerometerData *logMotion = [timer userInfo];
    
//    [XLabel setText:[NSString stringWithFormat:@"%f", logMotion.acceleration.x]];
//    [YLabel setText:[NSString stringWithFormat:@"%f", logMotion.acceleration.y]];
//    [ZLabel setText:[NSString stringWithFormat:@"%f", logMotion.acceleration.z]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[self motionManager] stopAccelerometerUpdates];
    [[self motionManager] stopGyroUpdates];
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
    
//    testQueue = dispatch_queue_create("testqueue", NULL);
//    dispatch_async(testQueue, ^{
//        NSURL *aapje = [NSURL URLWithString:@"http://bci.remcoraaijmakers.nl/api/v1/exercises"];
//        
//        NSString *test = [[NSString alloc] initWithContentsOfURL:aapje encoding:NSStringEncodingConversionAllowLossy error:nil];
//        NSLog(test);
//
//    });
}

- (IBAction)stopMotionDetection:(id)sender {
    NSLog(@"stopMotionDetection");
    [[self motionManager] stopAccelerometerUpdates];
    [[self motionManager] stopGyroUpdates];
    [timer invalidate];
}
@end

