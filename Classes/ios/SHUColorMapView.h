//
//  SHUColorMapView.h
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import <UIKit/UIKit.h>
#import "SHUBrightnessPickerView.h"

@class SHUColorMapView;

@protocol SHUColorMapViewDelegate <NSObject>

- (void) colormapView:(SHUColorMapView *)colorMapView didChangeHue:(CGFloat )hue saturation:(CGFloat )saturation;

@end

@interface SHUColorMapView : UIView  <SHUBrightnessPickerViewDataSource>

@property (weak, nonatomic) id <SHUColorMapViewDelegate> delegate;

@end
