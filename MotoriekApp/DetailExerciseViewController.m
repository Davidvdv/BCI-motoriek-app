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

@synthesize currentExercise;

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
    NSLog(@"%@", currentExercise);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
