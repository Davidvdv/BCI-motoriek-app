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

@synthesize motionLogs, timer, XAccelLabel, YAccelLabel, ZAccelLabel, XGyroLabel, YGyroLabel, ZGyroLabel, rollAttitudeLabel, pitchAttitudeLabel, yawAttitudeLabel;

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
    __block CMDeviceMotion *thisDeviceMotion;
    
    [motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect movingRect = self.movingView.frame;

            if (movingRect.origin.x + (deviceMotion.attitude.roll *15) >= 0 && movingRect.origin.x <= (self.view.frame.size.width - movingRect.size.width)) {
                movingRect.origin.x += deviceMotion.attitude.roll*15;
            }
            
            if(movingRect.origin.y + (deviceMotion.attitude.pitch *15) >= 0 && movingRect.origin.y <= (self.view.frame.size.height - movingRect.size.height)) {
                movingRect.origin.y += deviceMotion.attitude.pitch*15;
            }
            
            //movingRect.origin.x += deviceMotion.attitude.roll*15;
            //movingRect.origin.y += deviceMotion.attitude.pitch*15;
           
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
            
            thisDeviceMotion = deviceMotion;
        });
        
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logDataWithAcceleration) userInfo:thisDeviceMotion repeats:YES];
}

- (void) logDataWithAcceleration {
    
    NSDictionary *motion = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1.56", @"0.4576", @"1.00012", nil] forKeys:[NSArray arrayWithObjects:@"pitch", @"roll", @"yaw", nil]];
    [motionLogs addObject:motion];

    NSLog(@"%i", [motionLogs count]);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[self motionManager] stopDeviceMotionUpdates];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    motionLogs = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startMotionDetection:(id)sender {
    
    [self startMotionUpdates];
    //[self insertExercise];
}

- (IBAction)stopMotionDetection:(id)sender {
    [[self motionManager] stopDeviceMotionUpdates];
    [timer invalidate];
    //[self sendMotionLogsToServer];
}

- (void) insertExercise {
    // Core Data
    Exercise *exercise = (Exercise *)[NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:[self managedObjectContext]];
    
    [exercise setName:@"Remco"];
    [exercise setDatetime:[NSDate date]];
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    } else {
        NSLog(@"insertExercise");
    }
}

- (void) sendMotionLogsToServer {
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"Motion 1", @"name", motionLogs, @"motionlogs", nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSURL *aapje = [NSURL URLWithString:@"http://bci.remcoraaijmakers.nl/api/v1/exercises"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:aapje];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
     
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:nil];
    
    NSLog(@"%@", dic);
}

@end

