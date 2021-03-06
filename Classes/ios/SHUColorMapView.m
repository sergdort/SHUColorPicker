//
//  SHUColorMapView.m
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import "SHUColorMapView.h"

@interface SHUColorMapView ()

@property (weak, nonatomic)   UIImageView *mapImageView;
@property (weak, nonatomic)   UIView      *pickerView;
@property (assign, nonatomic) CGFloat     pickedHue;
@property (assign, nonatomic) CGFloat     pickedSaturation;

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


#pragma mark - Public

- (void) setStartHue:(CGFloat)hue saturation:(CGFloat)saturation{
    CGPoint center = CGPointMake(hue * self.mapImageView.frame.size.width,
                                 (1.0f - saturation) * self.mapImageView.frame.size.height);
    self.pickerView.center = center;
    self.pickerView.backgroundColor = [self _getColorFromPosition:center];
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
    if ([self.delegate respondsToSelector:@selector(colormapView:didChangeHue:saturation:)]) {
        [self.delegate colormapView:self didChangeHue:self.pickedHue saturation:self.pickedSaturation];
    }
}

- (void) _handleTouchs:(NSSet *)touches{
    CGPoint currentTouchPosition = [[touches anyObject] locationInView:self];
    [self _movePickerToPosition:currentTouchPosition];
    if ([self.delegate respondsToSelector:@selector(colormapView:didChangeHue:saturation:)]) {
        [self.delegate colormapView:self didChangeHue:self.pickedHue saturation:self.pickedSaturation];
    }
}

- (void) _movePickerToPosition:(CGPoint)position{
    if (CGRectContainsPoint(self.mapImageView.frame, position)) {
        self.pickerView.center = position;
        self.pickerView.backgroundColor = [self _getColorFromPosition:position];
    }
}

- (UIColor *) _getColorFromPosition:(CGPoint)position{
    
    self.pickedHue = (position.x - self.mapImageView.frame.origin.x) / self.mapImageView.frame.size.width;
    self.pickedSaturation = 1.0 - (position.y - self.mapImageView.frame.origin.y) / self.mapImageView.frame.size.height;
    
    UIColor *color = [UIColor colorWithHue:self.pickedHue
                                saturation:self.pickedSaturation
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

- (void ) getStartHue:(CGFloat *)startHue saturetion:(CGFloat *)saturation{
    *startHue = self.pickedHue;
    *saturation = self.pickedSaturation;
}



@end
