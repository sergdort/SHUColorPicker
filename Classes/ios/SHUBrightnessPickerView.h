//
//  BrightnessPickerView.h
//  Pods
//
//  Created by Sergey Shulga on 4/21/14.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHUBrightnessPickerViewType) {
    SHUBrightnessPickerViewVertical = 0,
    SHUBrightnessPickerViewHorisontal
};

@class SHUBrightnessPickerView;

@protocol SHUBrightnessPickerViewDataSource <NSObject>

- (void) getStartHue:(CGFloat*) startHue saturetion:(CGFloat *) saturation;

@end

@protocol SHUBrightnessPickerViewDelegate <NSObject>

- (void) brightnessPicker:(SHUBrightnessPickerView *)prightnessPicker didChangeBrightness:(CGFloat)brightness;

@end

@interface SHUBrightnessPickerView : UIView

@property (weak, nonatomic)   id <SHUBrightnessPickerViewDelegate>   delegate;
@property (weak, nonatomic)   id <SHUBrightnessPickerViewDataSource> dataSource;
@property (assign, nonatomic) SHUBrightnessPickerViewType            pickerType;
@property (assign, nonatomic) CGFloat                                startBrightness;

@end
