//
//  BrightnessPickerView.m
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import "SHUBrightnessPickerView.h"

@interface SHUBrightnessPickerView ()

@property (nonatomic, strong) UIColor *startColor;

@property (nonatomic, assign) BOOL    didSetuped;

@end

@implementation SHUBrightnessPickerView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.startColor = [self.dataSource startColorForBrightnessPicker];
    if (self.startColor) {
        [self drawGradient];
    }
    if (!self.didSetuped) {
        [self setupView];
    }
}

- (void)drawGradient{
    
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

#pragma mark - Private

- (void) setupView{
    
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

@end
