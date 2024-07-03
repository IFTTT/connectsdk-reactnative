import {
  requireNativeComponent,
  UIManager,
  Platform,
  type ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'connectsdk-reactnative' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type ConnectsdkReactnativeProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'ConnectsdkReactnativeView';

export const ConnectsdkReactnativeView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<ConnectsdkReactnativeProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
