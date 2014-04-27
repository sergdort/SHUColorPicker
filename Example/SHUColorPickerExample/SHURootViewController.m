//
//  SHURootViewController.m
//  SHUColorPickerExample
//
//  Created by Sergey Shulga on 4/27/14.
//  Copyright (c) 2014 Sergey Shulga. All rights reserved.
//

#import "SHURootViewController.h"
#import <SHUColorPicker/SHUColorPickerViewController.h>

@interface SHURootViewController () <SHUColorPickerViewControllerDelegate>

@end

@implementation SHURootViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
    SHUColorPickerViewController *colorPickerController = navigationController.viewControllers[0];
    colorPickerController.delegate = self;
    colorPickerController.startColor = self.view.backgroundColor;
}

- (void) colorPickerController:(SHUColorPickerViewController *)colorPickerController didPickColor:(UIColor *)color{
    self.view.backgroundColor = color;
}

@end
