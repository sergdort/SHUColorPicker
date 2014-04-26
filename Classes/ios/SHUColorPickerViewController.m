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

@interface SHUColorPickerViewController () <SHUColorMapViewDelegate, SHUBrightnessPickerViewDelegate>

@property (weak, nonatomic) IBOutlet SHUColorMapView         *colorMapView;
@property (weak, nonatomic) IBOutlet SHUBrightnessPickerView *brightnessPicker;
@property (assign, nonatomic)        CGFloat                 currentHue;
@property (assign, nonatomic)        CGFloat                 currentSaturation;
@property (assign, nonatomic)        CGFloat                 currentBrightness;

@end

@implementation SHUColorPickerViewController

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    self.currentBrightness = 1.0f;
    self.colorMapView.delegate = self;
    self.brightnessPicker.dataSource = self.colorMapView;
    self.brightnessPicker.pickerType = SHUBrightnessPickerViewVertical;
}

#pragma mark - SHUColorMapViewDelegate

- (void) colormapView:(SHUColorMapView *)colorMapView didChangeHue:(CGFloat)hue saturation:(CGFloat)saturation{
    
    if ([self.delegate respondsToSelector:@selector(colorPickerController:didPickColor:)]) {
        UIColor *pickedColor = [UIColor colorWithHue:self.currentHue
                                          saturation:self.currentSaturation
                                          brightness:self.currentBrightness alpha:1.f];
        [self.delegate colorPickerController:self didPickColor:pickedColor];
    }
    
    [self.brightnessPicker setNeedsDisplay];
}


#pragma mark - SHUBrightnessPickerViewDelegate

- (void) brightnessPicker:(SHUBrightnessPickerView *)prightnessPicker didChangeBrightness:(CGFloat)brightness{
    self.currentBrightness = brightness;
}


@end
