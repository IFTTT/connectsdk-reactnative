import {
  requireNativeComponent,
  UIManager,
  Platform,
  type ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-connectsdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

// TODO: Add documentation
type ConnectsdkProps = {
  connectionId: string;
  suggestedUserEmail: string;
  redirectURL: string;
  skipConnectionConfiguration: boolean;
  oauthCode: string;
  inviteCode: string;
  userToken: string;

  onActivationSuccess: Function;
  onActivationFailure: Function;
  onDeactivationSuccess: Function;
  onDeactivationFailure: Function;

  style: ViewStyle;
};

const ComponentName = 'RCTConnectButtonView';

export const ConnectButton =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<ConnectsdkProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
