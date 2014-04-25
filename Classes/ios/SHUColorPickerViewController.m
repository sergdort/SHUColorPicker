//
//  SHUColorPickerViewController.m
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import "SHUColorPickerViewController.h"
#import "SHUColorMapView.h"
#import "SHUBrightnessPickerView.h"

@interface SHUColorPickerViewController () <SHUColorMapViewDelegate>

@property (weak, nonatomic) IBOutlet SHUColorMapView         *colorMapView;
@property (weak, nonatomic) IBOutlet SHUBrightnessPickerView *brightnessPicker;

@end

@implementation SHUColorPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorMapView.delegate = self;
    self.brightnessPicker.dataSource = self.colorMapView;
    self.brightnessPicker.pickerType = SHUBrightnessPickerViewVertical;
}

#pragma mark - SHUColorMapViewDelegate

- (void)colormapView:(SHUColorMapView *)colorMapView didChangeColor:(UIColor *)color{
    
    if ([self.delegate respondsToSelector:@selector(colorPickerController:didPickColor:)]) {
        [self.delegate colorPickerController:self didPickColor:color];
    }
    
    [self.brightnessPicker setNeedsDisplay];
}

@end
