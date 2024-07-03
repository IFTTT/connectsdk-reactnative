import {
  requireNativeComponent,
  UIManager,
  Platform,
  type ViewStyle,
} from 'react-native';

import PropTypes from 'prop-types';

const LINKING_ERROR =
  `The package 'react-native-connectsdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

// TODO: Add documentation
type ConnectsdkProps = {
  connectionId: PropTypes.string;
  suggestedUserEmail: PropTypes.string;
  redirectURL: PropTypes.string;
  skipConnectionConfiguration: PropTypes.bool;
  oauthCode: PropTypes.string;
  inviteCode: PropTypes.string;
  userToken: PropTypes.string;

  onActivationSuccess: PropTypes.func;
  onActivationFailure: PropTypes.func;
  onDeactivationSuccess: PropTypes.func;
  onDeactivationFailure: PropTypes.func;

  style: ViewStyle;
};

const ComponentName = 'RCTConnectButtonView';

export const ConnectButton =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<ConnectsdkProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
