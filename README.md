# react-native-mixpanel-bridge
React Native bridge to the Mixpanel libraries on both iOS and Android.

This is inspired by https://github.com/davodesign84/react-native-mixpanel but includes the Mixpanel iOS SDK so you don't need aditional installation steps.

**Important:** this was only tested with React Native `0.36.0`. It's known it doesn't work with versions >= `0.40.0` due to changes on location of React Native headers.

## Installation

Install the module: `npm install --save react-native-mixpanel-bridge`

Link to your project: `react-native link react-native-mixpanel-bridge`

## Usage
```javascript
import Mixpanel from 'react-native-mixpanel-bridge';

Mixpanel.sharedWithInstanceToken('YOUR_PROJECT_TOKEN');

// track something
Mixpanel.track('Event');
Mixpanel.trackWithProperties('Event', { propertiesObject });
Mixpanel.registerSuperProperties({ superProperties });
Mixpanel.registerSuperPropertiesOnce({ superProperties });
Mixpanel.increment('Event', 1);

// Identify user
Mixpanel.identify('USER_ID');
Mixpanel.set({ userProperties });
Mixpanel.setOnce({ userProperties });

// Timing events
Mixpanel.timeEvent('Event'); // start
Mixpanel.track('Event'); // end
```

See the [Mixpanel reference (for iOS)](https://mixpanel.com/help/reference/ios) for more information.

## Thanks

Thanks to @davodesign84 for the bridge code.
