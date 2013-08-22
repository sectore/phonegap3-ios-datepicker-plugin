//  Phonegap DatePicker Plugin
//  Copyright (c) Greg Allen 2011
//  Refactored to Phonegap 3.0.0 (incl. some more options) by Jens Krause (www.websector.de)
//  MIT Licensed

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#ifndef k_DATEPICKER_DATETIME_FORMAT
#define k_DATEPICKER_DATETIME_FORMAT @"yyyy-MM-dd'T'HH:mm:ss'Z'"
#endif

@interface DatePicker : CDVPlugin <UIActionSheetDelegate> {
  UIActionSheet *_datePickerSheet;
  UIDatePicker *_datePicker;
  BOOL isVisible;
}

@property (nonatomic) UIActionSheet* datePickerSheet;
@property (nonatomic) UIDatePicker* datePicker;

- (void)show:(CDVInvokedUrlCommand*)command;

@end
