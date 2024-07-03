#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(RCTConnectButtonViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(oauthCode, NSString)
RCT_EXPORT_VIEW_PROPERTY(inviteCode, NSString)
RCT_EXPORT_VIEW_PROPERTY(userToken, NSString)

RCT_EXPORT_VIEW_PROPERTY(connectionId, NSString)
RCT_EXPORT_VIEW_PROPERTY(suggestedUserEmail, NSString)
RCT_EXPORT_VIEW_PROPERTY(redirectURL, NSString)
RCT_EXPORT_VIEW_PROPERTY(skipConnectionConfiguration, BOOL)

RCT_EXPORT_VIEW_PROPERTY(onActivationSuccess, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onActivationFailure, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDeactivationSuccess, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDeactivationFailure, RCTDirectEventBlock)
@end
