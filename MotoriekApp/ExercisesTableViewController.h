//
//  ExercisesTableViewController.h
//  MotoriekApp
//
//  Created by David van de Vondervoort on 16-04-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface ExercisesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
