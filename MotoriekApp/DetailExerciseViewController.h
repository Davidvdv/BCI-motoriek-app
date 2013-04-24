//
//  DetailExerciseViewController.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 23-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface DetailExerciseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *exerciseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseDatetimeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webViewGraph;

@property (strong, nonatomic) Exercise *currentExercise;

@end
