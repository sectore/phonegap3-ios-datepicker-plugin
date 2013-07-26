//  Phonegap DatePicker Plugin
//  Copyright (c) Greg Allen 2011
//  Updated to Phonegap 3.0.0 by Jens Krause (www.websector.de)
//  MIT Licensed

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#ifndef k_DATEPICKER_DATETIME_FORMAT
#define k_DATEPICKER_DATETIME_FORMAT @"yyyy-MM-dd'T'HH:mm:ss'Z'"
#endif

// @interface DatePicker : CDVPlugin <UIActionSheetDelegate> {
@interface DatePicker : CDVPlugin {
  UIActionSheet *_datePickerSheet;
  UIDatePicker *_datePicker;
  NSDateFormatter *_isoDateFormatter;
  BOOL isVisible;
}

@property (nonatomic) UIActionSheet* datePickerSheet;
@property (nonatomic) UIDatePicker* datePicker;
@property (nonatomic) NSDateFormatter* isoDateFormatter;


//- (void) prepare:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
// - (void) show:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void)show:(CDVInvokedUrlCommand*)command;

@end
