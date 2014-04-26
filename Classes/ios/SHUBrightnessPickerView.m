//
//  BrightnessPickerView.m
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import "SHUBrightnessPickerView.h"

@interface SHUBrightnessPickerView ()

@property (strong, nonatomic) UIColor  *startColor;
@property (assign, nonatomic) BOOL      didSetuped;
@property (weak, nonatomic)   UISlider *slider;

@end

@implementation SHUBrightnessPickerView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.startColor = [self.dataSource startColorForBrightnessPicker];
    if (self.startColor) {
        self.slider.thumbTintColor = [self _getColorFromSliderValuer:self.slider.value];
        [self _drawGradient];
    }
    if (!self.didSetuped) {
        [self _setupView];
        [self _createSliderView];
    }
}

#pragma mark - Private

- (void) _drawGradient{
    
    const CGFloat *componets = CGColorGetComponents(self.startColor.CGColor);
    
    CGFloat colors[] = {
		0.f, 0.f, 0.f, 1.f,
		componets[0], componets[1], componets[2], 1.0f
	};
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient;
    
	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(rgb);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGRect clippingRect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    
	CGPoint *endPoints = (CGPoint*) malloc(2 * sizeof(CGPoint));
    
    if (self.pickerType) {
        endPoints[0] = CGPointMake(0,0);
        endPoints[1] = CGPointMake(self.frame.size.width, 0.0f);
    }else{
        endPoints[0] = CGPointMake(0, 0);
        endPoints[1] = CGPointMake(0.0f, self.frame.size.height);
    }
	
	CGContextSaveGState(context);
	CGContextClipToRect(context, clippingRect);
	
	CGContextDrawLinearGradient(context, gradient, endPoints[0], endPoints[1], 0);
	CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    free(endPoints);
}

- (void) _setupView{
    
    self.didSetuped = YES;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.masksToBounds = YES;
    
    if (self.pickerType == SHUBrightnessPickerViewVertical) {
        
        self.layer.cornerRadius = self.frame.size.width / 4.f;
        
    }else{
        
        self.layer.cornerRadius = self.frame.size.height / 4.f;
        
    }
    
}

- (void) _createSliderView{
    UISlider *slider = [[UISlider alloc] init];
    [self addSubview:slider];
    self.slider = slider;
    slider.transform = CGAffineTransformMakeRotation(M_PI_2);
    [slider setFrame:self.bounds];
    [slider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
    slider.minimumTrackTintColor = [UIColor clearColor];
    slider.maximumTrackTintColor = [UIColor clearColor];
    [slider setThumbImage:[UIImage imageNamed:@"colormap"] forState:UIControlStateNormal];
    slider.thumbTintColor = self.startColor;
    slider.minimumValue = 0.;
    slider.maximumValue = 1.0;
    slider.value = 1.0;
}

- (UIColor *) _getColorFromSliderValuer:(CGFloat )valuer{
    CGFloat hue = 0, saturation = 0;
    [self.startColor getHue:&hue saturation:&saturation brightness:NULL alpha:NULL];
    
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:valuer alpha:1.f];
}

#pragma mark - Actions

- (void) sliderMoved:(UISlider *)slider{
    slider.thumbTintColor = [self _getColorFromSliderValuer:slider.value];
    if ([self.delegate respondsToSelector:@selector(brightnessPicker:didChangeBrightness:)]) {
        [self.delegate brightnessPicker:self didChangeBrightness:slider.value];
    }
}

@end
