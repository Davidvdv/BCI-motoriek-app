//
//  DetailExerciseViewController.m
//  MotoriekApp
//
//  Created by David van de Vondervoort on 23-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "DetailExerciseViewController.h"

@interface DetailExerciseViewController ()

@end

@implementation DetailExerciseViewController

@synthesize currentExercise, exerciseDatetimeLabel, webViewGraph;

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
    
    [self setTitle:currentExercise.name];
    
    NSString *exerciseDatetime = [NSDateFormatter localizedStringFromDate:currentExercise.datetime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    [exerciseDatetimeLabel setText:exerciseDatetime];
    
    NSString *url = [NSString stringWithFormat:@"http://bci.remcoraaijmakers.nl/inapp.html#%@",currentExercise.apiNumber];

    NSURLRequest *webviewRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[webViewGraph scrollView] setBounces:NO];
    [webViewGraph loadRequest:webviewRequest];
    
    NSSet *setWithMotionLogs = currentExercise.motionLog;
    
    for (MotionLog *theMotionLog in setWithMotionLogs) {
        NSLog(@"log this - %@", theMotionLog);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"modalSegue"]) {
        MotionLogsViewController *motionLogsViewController = [segue destinationViewController];
        [motionLogsViewController setMotionsBelongsToExercise:currentExercise.name];
        [motionLogsViewController setMotionLogs:[currentExercise.motionLog allObjects]];
    }
}

@end
