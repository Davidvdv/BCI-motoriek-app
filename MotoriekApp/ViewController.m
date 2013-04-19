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

@synthesize timer;
@synthesize XAccelLabel, YAccelLabel, ZAccelLabel, XGyroLabel, YGyroLabel, ZGyroLabel, rollAttitudeLabel, pitchAttitudeLabel, yawAttitudeLabel;

- (CMMotionManager *)motionManager {

    CMMotionManager *motionManager = nil;
    id appDelegate = [[UIApplication sharedApplication] delegate];
    
    if([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (NSManagedObjectContext *) managedObjectContext {

    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
        
    return managedObjectContext;
}

- (void) startMotionUpdates {
    CMMotionManager *motionManager = [self motionManager];
    
    [motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect movingRect = self.movingView.frame;

//            if (movingRect.origin.x < self.view.frame.size.width && movingRect.origin.x > 0) {
//                movingRect.origin.x += deviceMotion.acceleration.x *15;
//            }
//            
//            if(movingRect.origin.y > 0 && movingRect.origin.y < self.view.frame.origin.y) {
//                 movingRect.origin.y -= deviceMotion.acceleration.y *15;
//            }
            movingRect.origin.x += deviceMotion.attitude.roll*15;
            movingRect.origin.y += deviceMotion.attitude.pitch*15;
           
            if (CGRectContainsRect(self.view.bounds, movingRect)) {
                self.view.backgroundColor = [UIColor whiteColor];
            } else {
                self.view.backgroundColor = [UIColor redColor];
            }

            self.movingView.frame = movingRect;
            
            // Accelerometer
            [XAccelLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.userAcceleration.x]];
            [YAccelLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.userAcceleration.y]];
            [ZAccelLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.userAcceleration.z]];
            
            // Gyro ration rate
            [XGyroLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.rotationRate.x]];
            [YGyroLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.rotationRate.y]];
            [ZGyroLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.rotationRate.z]];
            
            // Attitude ration rate
            [rollAttitudeLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.attitude.roll]];
            [pitchAttitudeLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.attitude.pitch]];
            [yawAttitudeLabel setText:[NSString stringWithFormat:@"%f", deviceMotion.attitude.yaw]];
        });
        
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logDataWithAcceleration) userInfo:nil repeats:YES];
}

- (void) logDataWithAcceleration {
    NSLog(@"logDataWithAcceleration");
    
//    [XLabel setText:[NSString stringWithFormat:@"%f", logMotion.acceleration.x]];
//    [YLabel setText:[NSString stringWithFormat:@"%f", logMotion.acceleration.y]];
//    [ZLabel setText:[NSString stringWithFormat:@"%f", logMotion.acceleration.z]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[self motionManager] stopDeviceMotionUpdates];
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
    [self insertExercise];
    
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
    [[self motionManager] stopDeviceMotionUpdates];
    [timer invalidate];
}

- (void) insertExercise {
    // Core Data
    Exercise *exercise = (Exercise *)[NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:[self managedObjectContext]];
    
    [exercise setName:@"David"];
    [exercise setDatetime:[NSDate date]];
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

@end

