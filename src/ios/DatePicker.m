//	Phonegap DatePicker Plugin
//	Copyright (c) Greg Allen 2011
//	MIT Licensed
//
//  Additional refactoring by Sam de Freyssinet
//	Refactored to Phonegap 3.0.0 (incl. some more options) by Jens Krause (www.websector.de)

#import "DatePicker.h"
#import <Cordova/CDV.h>

@interface DatePicker (Private)

// Initialize the UIActionSheet with ID <UIActionSheetDelegate> delegate UIDatePicker datePicker (UISegmentedControl)closeButton
- (UIActionSheet *)createActionSheet:(id <UIActionSheetDelegate>)delegateOrNil datePicker:(UIDatePicker *)datePicker closeButton:(UISegmentedControl *)closeButton;

// Creates the NSDateFormatter with NSString format and NSTimeZone timezone
- (NSDateFormatter *)createISODateFormatter:(NSString *)format timezone:(NSTimeZone *)timezone;

// Creates the UIDatePicker with CGRect frame, NSDateFormatter formatter and NSMutableDictionary options
- (UIDatePicker *)createDatePicker:(CGRect)frame formatter:(NSDateFormatter *)formatter options:(NSMutableDictionary *)options;

// Creates the UISegmentedControl with NSString title
- (UISegmentedControl *)createActionSheetCloseButton:(NSString *)title;

@end

@implementation DatePicker

@synthesize datePickerSheet = _datePickerSheet;
@synthesize datePicker = _datePicker;

#pragma mark - Public Methods

//- (void)show:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
- (void)show:(CDVInvokedUrlCommand*)command;
{
	if (isVisible) {
		return;        
	}
  
	NSMutableDictionary *options = [command argumentAtIndex:0];

	NSDateFormatter *isoTimeFormatter = [self createISODateFormatter:k_DATEPICKER_DATETIME_FORMAT timezone:[NSTimeZone defaultTimeZone]];

  CGRect datePickerRect = CGRectMake(0, 40, 0, 0);
	UIDatePicker *datePicker = [self createDatePicker:datePickerRect formatter:isoTimeFormatter options:options];
	self.datePicker = datePicker;

	//NSString *closeButtonLabel = [options objectForKey:@"closeButtonLabel"] ?: @"Close";
	NSString *closeButtonLabel = [options objectForKey:@"closeButtonLabel"];
	UISegmentedControl *datePickerCloseButton = [self createActionSheetCloseButton:closeButtonLabel];

	self.datePickerSheet = [self createActionSheet:self datePicker:datePicker closeButton:datePickerCloseButton];

	isVisible = YES;
}

- (void)dismissActionSheet:(id)sender {
	[self.datePickerSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)onMemoryWarning
{
	// It could be better to close the datepicker before the system
	// clears memory. But in reality, other non-visible plugins should
	// be tidying themselves at this point. This could cause a fatal
	// at runtime.
	if (isVisible) {
		return;
	}
}

#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	NSTimeInterval seconds = [self.datePicker.date timeIntervalSince1970];
	NSString* jsCallback = [NSString stringWithFormat:@"datePicker._dateSelected(\"%f\");", seconds];
	[super writeJavascript:jsCallback];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	isVisible = NO;
}

#pragma mark - Private Methods

- (UIActionSheet *)createActionSheet:(id <UIActionSheetDelegate>)delegateOrNil datePicker:(UIDatePicker *)datePicker closeButton:(UISegmentedControl *)closeButton
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
																	delegate:delegateOrNil 
																	cancelButtonTitle:nil 
																	destructiveButtonTitle:nil 
																	otherButtonTitles:nil];

	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];

	[actionSheet addSubview:datePicker];
	[actionSheet addSubview:closeButton];    
    
	[actionSheet showInView:[[super webView] superview]];
	[actionSheet setBounds:CGRectMake(0, 0, 320, 485)];

	return actionSheet;
}

- (UIDatePicker *)createDatePicker:(CGRect)frame formatter:(NSDateFormatter *)formatter options:(NSMutableDictionary *)options
{
	UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:frame];

  NSString *mode = [options objectForKey:@"mode"];
	NSString *dateString = [options objectForKey:@"date"];
	BOOL allowOldDates = NO;
	BOOL allowFutureDates = YES;
	NSString *minDateString = [options objectForKey:@"minDate"];
	NSString *maxDateString = [options objectForKey:@"maxDate"];
    
	if ([[options objectForKey:@"allowOldDates"] intValue] == 1) {
		allowOldDates = YES;
	}
    
	if ( !allowOldDates) {
		datePicker.minimumDate = [NSDate date];
	}
    
	if(minDateString){
		datePicker.minimumDate = [formatter dateFromString:minDateString];
	}
	
	if ([[options objectForKey:@"allowFutureDates"] intValue] == 0) {
		allowFutureDates = NO;
	}
    
	if ( !allowFutureDates) {
		datePicker.maximumDate = [NSDate date];
	}
    
	if(maxDateString){
		datePicker.maximumDate = [formatter dateFromString:maxDateString];
	}
    
	datePicker.date = [formatter dateFromString:dateString];
    
	if ([mode isEqualToString:@"date"]) {
		datePicker.datePickerMode = UIDatePickerModeDate;
	}
	else if ([mode isEqualToString:@"time"])
	{
		datePicker.datePickerMode = UIDatePickerModeTime;
	}
	else
	{
		datePicker.datePickerMode = UIDatePickerModeDateAndTime;
	}
    
	return datePicker;
}

- (NSDateFormatter *)createISODateFormatter:(NSString *)format timezone:(NSTimeZone *)timezone;
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:timezone];
	[dateFormatter setDateFormat:format];

	return dateFormatter;
}

- (UISegmentedControl *)createActionSheetCloseButton:(NSString *)title
{
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:title]];

	closeButton.momentary = YES;
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor blackColor];
	closeButton.apportionsSegmentWidthsByContent = YES;
    
  CGRect bounds = closeButton.bounds;
  CGFloat width = bounds.size.width;
  CGFloat height = bounds.size.height;
  CGFloat xPos = 320 - width - 10; // 320 == width of DatePicker, 10 == offset to right side hand
  closeButton.frame = CGRectMake(xPos, 7.0f, width, height);

	[closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];

	return closeButton;
}

@end
