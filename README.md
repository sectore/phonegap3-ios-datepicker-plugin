# DatePicker iOS Plugin for using PhoneGap 3.0

This is a port of the iOS DatePicker plugin hosted on [https://github.com/phonegap/phonegap-plugins/tree/master/iOS/DatePicker](https://github.com/phonegap/phonegap-plugins/tree/master/iOS/DatePicker)

## Screen shot

[![screen shot](https://raw.github.com/sectore/phonegap3-ios-datepicker-plugin/master/assets/screenshot.png)](https://github.com/sectore/phonegap3-ios-datepicker-plugin)


## Installation

1) Make sure that you have [Node](http://nodejs.org/) and [Cordova CLI](https://github.com/apache/cordova-cli) or [PhoneGap's CLI](https://github.com/mwbrooks/phonegap-cli) or [Cordova Plugman](https://github.com/apache/cordova-plugman/) installed on your machine.

2) Add a plugin to your project using [Cordova CLI](https://github.com/apache/cordova-cli):

```bash
cordova plugin add https://github.com/sectore/phonegap3-ios-datepicker-plugin
```

Or using [Phonegap CLI](https://github.com/mwbrooks/phonegap-cli):

```bash
phonegap local plugin add https://github.com/sectore/phonegap3-ios-datepicker-plugin
```

Or using [plugman CLI](https://github.com/apache/cordova-plugman#command-line-usage):

```bash
plugman --platform ios --project ./platforms/ios --plugin https://github.com/sectore/phonegap3-ios-datepicker-plugin
```


3) Register plugin within `config.xml` of your app

```xml
<feature name="DatePicker">
    <param name="ios-package" value="DatePicker"/>
</feature>
```

4) The `clobber` definition of the plugin is called `datePicker`. So you can reference to the plugin from anywhere in your code.

Example:

```js
// defining options
var options = {
  date: new Date(),
  mode: 'date'
};
// calling show() function with options and a result handler
datePicker.show(options, function(date){
  console.log("date result " + date);  
});
```

## Author of migration to PhoneGap 3.0
Jens Krause // [WEBSECTOR.DE](http://www.websector.de) 


