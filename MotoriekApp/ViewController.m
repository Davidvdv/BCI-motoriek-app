//
//  ViewController.m
//  MotoriekApp
//
//  Created by David van de Vondervoort on 15-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController () {
    NSMutableDictionary *motion;
}

@end

@implementation ViewController

@synthesize exercise, motionLogs, timer, XAccelLabel, YAccelLabel, ZAccelLabel, XGyroLabel, YGyroLabel, ZGyroLabel, rollAttitudeLabel, pitchAttitudeLabel, yawAttitudeLabel;

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

#pragma mark - Motion methods

- (void) startMotionUpdates {
    CMMotionManager *motionManager = [self motionManager];

    [motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect movingRect = self.movingView.frame;

            /*if (movingRect.origin.x + (deviceMotion.attitude.roll *15) >= 0 && movingRect.origin.x <= (self.view.frame.size.width - movingRect.size.width)) {
                movingRect.origin.x += deviceMotion.attitude.roll*15;
            }
            
            if(movingRect.origin.y + (deviceMotion.attitude.pitch *15) >= 0 && movingRect.origin.y <= (self.view.frame.size.height - movingRect.size.height)) {
                movingRect.origin.y += deviceMotion.attitude.pitch*15;
            }*/

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
            
            /*NSNumber *roll = [NSNumber numberWithDouble:deviceMotion.attitude.roll];
            NSNumber *pitch = [NSNumber numberWithDouble:deviceMotion.attitude.roll];
            NSNumber *yaw = [NSNumber numberWithDouble:deviceMotion.attitude.yaw];
            
            motion = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:pitch, roll, yaw, nil] forKeys:[NSArray arrayWithObjects:@"pitch", @"roll", @"yaw", nil]];*/
            
        });
        
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logMotionData) userInfo:nil repeats:YES];
}

- (void)logMotionData {
    
    NSDictionary *loggedMotion = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:pitchAttitudeLabel.text, rollAttitudeLabel.text, yawAttitudeLabel.text, nil] forKeys:[NSArray arrayWithObjects:@"pitch", @"roll", @"yaw", nil]];
    [motionLogs addObject:loggedMotion];
}

- (IBAction)startMotionDetection:(id)sender {
    
    [self startMotionUpdates];
    [self insertExercise];
}

- (IBAction)stopMotionDetection:(id)sender {
    [[self motionManager] stopDeviceMotionUpdates];
    [timer invalidate];
    [self sendMotionLogsToServer];
    NSLog(@"%@", motionLogs);
}

- (void)motionEnded:(UIEventSubtype)motionEvent withEvent:(UIEvent *)event
{
    if (motionEvent == UIEventSubtypeMotionShake) {
        UIAlertView *shakeAlert = [[UIAlertView alloc] initWithTitle:@"Shake" message:@"Je hebt geschud. Let nu op de Philips Hue" delegate:nil cancelButtonTitle:@"Nice" otherButtonTitles:nil];
        [shakeAlert show];
    }
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    motionLogs = [[NSMutableArray alloc] init];
    motion = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[self motionManager] stopDeviceMotionUpdates];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Save logged motions

- (void) insertExercise {
    // Core Data
    exercise = (Exercise *)[NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:[self managedObjectContext]];
    
    [exercise setName:@"Motion 1"];
    [exercise setDatetime:[NSDate date]];
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void) sendMotionLogsToServer {
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:exercise.name, @"name", motionLogs, @"motionlogs", nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSURL *aapje = [NSURL URLWithString:@"http://bci.remcoraaijmakers.nl/api/v1/exercises"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:aapje];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
     
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:nil];
    
    NSLog(@"sendMotionLogsToServer %@", dic);
}

@end