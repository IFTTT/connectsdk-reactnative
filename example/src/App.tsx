import * as React from 'react';

import { StyleSheet, View } from 'react-native';
import { ConnectButton } from 'connectsdk-reactnative';

var onActivationSuccess = function (event) {
  console.log('onActivationSuccess: ');
  console.log('userToken: ' + event.nativeEvent.userToken);
  console.log('connection: ' + event.nativeEvent.connection);
};

var onActivationFailure = function (event) {
  console.log('onActivationFailure: ');
  console.log('error code: ' + event.nativeEvent.code);
  console.log('error domain: ' + event.nativeEvent.domain);
  console.log('error user info: ' + event.nativeEvent.user_info);
};

var onDeactivationSuccess = function (event) {
  console.log('onDeactivationSuccess: ');
  console.log('connection details: ' + event.nativeEvent.details);
};

var onDeactivationFailure = function (event) {
  console.log('onDeactivationFailure: ');
  console.log('error code: ' + event.nativeEvent.code);
  console.log('error domain: ' + event.nativeEvent.domain);
  console.log('error user info: ' + event.nativeEvent.user_info);
};

export default function App() {
  const styles = StyleSheet.create({
    container: {
      flex: 1,
      alignItems: 'center',
      justifyContent: 'center',
    },
    box: {
      width: 370,
      height: 120,
    },
  });
  return (
    <View style={styles.container}>
      <ConnectButton
        connectionId={'fWj4fxYg'}
        suggestedUserEmail={'suggestedUserEmail@somedomain.com'}
        redirectURL={'connectsdktestapp://connect_callback'}
        skipConnectionConfiguration={false}
        onActivationSuccess={onActivationSuccess}
        onActivationFailure={onActivationFailure}
        onDeactivationSuccess={onDeactivationSuccess}
        onDeactivationFailure={onDeactivationFailure}
        style={styles.box}
      />
    </View>
  );
}
