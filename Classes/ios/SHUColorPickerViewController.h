//
//  SHUColorPickerViewController.h
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import <UIKit/UIKit.h>

@class SHUColorPickerViewController;

@protocol SHUColorPickerViewControllerDelegate <NSObject>

- (void) colorPickerController:(SHUColorPickerViewController *)colorPickerController didPickColor:(UIColor *)color;

@end

@interface SHUColorPickerViewController : UIViewController

@property (weak, nonatomic) id <SHUColorPickerViewControllerDelegate> delegate;

@end
