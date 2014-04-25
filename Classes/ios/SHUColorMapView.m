//
//  SHUColorMapView.m
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import "SHUColorMapView.h"

@interface SHUColorMapView ()

@property (weak, nonatomic) UIImageView *mapImageView;
@property (weak, nonatomic) UIView      *pickerView;

@end

@implementation SHUColorMapView

- (id) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _createMapImageViewWithFrame:[self bounds]];
        [self _createPickerView];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self _createMapImageViewWithFrame:[self bounds]];
        [self _createPickerView];
    }
    
    return self;
}

#pragma mark - Pivate

- (void) _createMapImageViewWithFrame:(CGRect)frame{
    
    UIImageView *colorMapImageView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:@"colormap"];
    
    colorMapImageView.image = image;
    colorMapImageView.layer.cornerRadius = self.frame.size.width < self.frame.size.height ?
    self.frame.size.width / 10.f : self.frame.size.height / 10.f;
    colorMapImageView.layer.borderColor = [UIColor blackColor].CGColor;
    colorMapImageView.layer.borderWidth = .5f;
    colorMapImageView.layer.masksToBounds = YES;
    
    [self addSubview:colorMapImageView];
    self.mapImageView = colorMapImageView;
}

- (void) _createPickerView{
    
    UIView *pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32.f, 32.f)];
    pickerView.backgroundColor = [self _getColorFromPosition:pickerView.center];
    pickerView.layer.cornerRadius = pickerView.frame.size.height / 2.f;
    pickerView.layer.borderColor = [UIColor lightTextColor].CGColor;
    pickerView.layer.shadowColor = [UIColor blackColor].CGColor;
    pickerView.layer.shadowOffset = CGSizeZero;
    pickerView.layer.shadowRadius = 1.f;
    pickerView.layer.shadowOpacity = .7f;
    pickerView.layer.borderWidth = 2.f;
    pickerView.layer.masksToBounds = YES;
    
    [self addSubview:pickerView];
    self.pickerView = pickerView;
}

- (void) _handleTouchs:(NSSet *)touches{
    CGPoint currentTouchPosition = [[touches anyObject] locationInView:self];
    [self _movePickerToPosition:currentTouchPosition];
    if ([self.delegate respondsToSelector:@selector(colormapView:didChangeColor:)]) {
        [self.delegate colormapView:self didChangeColor:[self _getColorFromPosition:currentTouchPosition]];
    }
}

- (void) _movePickerToPosition:(CGPoint)position{
    if (CGRectContainsPoint(self.mapImageView.frame, position)) {
        self.pickerView.center = position;
        self.pickerView.backgroundColor = [self _getColorFromPosition:position];
    }
}

- (UIColor *) _getColorFromPosition:(CGPoint)position{
    
    CGFloat hue = (position.x - self.mapImageView.frame.origin.x) / self.mapImageView.frame.size.width;
    CGFloat saturation = 1.0 - (position.y - self.mapImageView.frame.origin.y) / self.mapImageView.frame.size.height;
    
    UIColor *color = [UIColor colorWithHue:hue
                                saturation:saturation
                                brightness:1.f
                                     alpha:1.0];
    
    return color;
}

#pragma mark - Touch actions

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self _handleTouchs:touches];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self _handleTouchs:touches];
}


#pragma mark - SHUBrightnessPickerViewDataSource

- (UIColor *) startColorForBrightnessPicker{
    return [self _getColorFromPosition:self.pickerView.center];
}



@end
