# connectsdk-reactnative

The ReactNative wrapper for the IFTTT ConnectSDK.

## Installation

```sh
npm install connectsdk-reactnative
```

## Usage


```js
import { ConnectButton } from 'connectsdk-reactnative';

// ...
<ConnectButton
	connectionId={'<The Id of the connection that should be displayed. Example: >'}
	suggestedUserEmail={'<An email address corresponding to the user that is logged in.>'}
	redirectURL={'<The redirect URL to use when invoking your iOS app after a service is connected. Example: connectsdktestapp://connect_callback'}
	skipConnectionConfiguration={false}	// Whether or not connection configuration should be skipped.
	onActivationSuccess={onActivationSuccess} // Callback for Connection activation success
	onActivationFailure={onActivationFailure} // Callback for Connection activation failure
	onDeactivationSuccess={onDeactivationSuccess} // Callback for Connection deactivation success
	onDeactivationFailure={onDeactivationFailure} // Callback for Connection deactivation failure
/>
```

## Running locally
In order to see an example of the wrapper, you'll need the following dependencies:
- yarn
- npm
- Cocoapods

1. Clone the repository
2. Run `yarn` to setup yarn dependencies
3. Go to `example/ios` folder
4. Run `pod install` to setup Cocoapods for the example project. 
5. Go back to root of the repository.
6. Run `yarn example ios` to run the iOS app.

To see usage of the ConnectButton in Typescript, go to `example/src/App.tsx`.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
