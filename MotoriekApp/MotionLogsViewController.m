//
//  MotionLogsViewController.m
//  MotoriekApp
//
//  Created by David van de Vondervoort on 25-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "MotionLogsViewController.h"

@interface MotionLogsViewController ()

@end

@implementation MotionLogsViewController

@synthesize motionLogs, motionsBelongsToExercise;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return motionsBelongsToExercise;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [motionLogs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MotionLogCell";
    MotionLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell == nil) {
        cell = [[MotionLogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MotionLog *motionLog = [motionLogs objectAtIndex:indexPath.row];
    
    [cell.XAccelLabel setText:[NSString stringWithFormat:@"%@", motionLog.accelX]];
    [cell.YAccelLabel setText:[NSString stringWithFormat:@"%@", motionLog.accelY]];
    [cell.ZAccelLabel setText:[NSString stringWithFormat:@"%@", motionLog.accelZ]];
    
    [cell.XGyroLabel setText:[NSString stringWithFormat:@"%@", motionLog.gyroX]];
    [cell.YGyroLabel setText:[NSString stringWithFormat:@"%@", motionLog.gyroY]];
    [cell.ZGyroLabel setText:[NSString stringWithFormat:@"%@", motionLog.gyroZ]];
    
    [cell.rollAttitudeLabel setText:[NSString stringWithFormat:@"%@", motionLog.roll]];
    [cell.pitchAttitudeLabel setText:[NSString stringWithFormat:@"%@", motionLog.pitch]];
    [cell.yawAttitudeLabel setText:[NSString stringWithFormat:@"%@", motionLog.yaw]];
    
    return cell;
}

@end
