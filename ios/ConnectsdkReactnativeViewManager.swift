import Foundation
import UIKit
import IFTTTConnectSDK_ReactNative

class RCTConnectButtonCredentialProvider: ConnectionCredentialProvider {
    var inviteCode: String?
    var oauthCode: String
    var userToken: String?

    init(inviteCode: String? = nil, oauthCode: String, userToken: String? = nil) {
        self.inviteCode = inviteCode
        self.oauthCode = oauthCode
        self.userToken = userToken
    }
}

class RCTConnectButtonWrapper: UIView {
    private var connectButton: ConnectButton
    
    private var connectButtonController: ConnectButtonController?
    private var credentialProvider: RCTConnectButtonCredentialProvider?
    
    private var connectionId: String?
    private var suggestedUserEmail: String?
    private var redirectURL: URL?
    private var skipConnectionConfiguration: Bool?
    
    private var oauthCode: String = ""
    private var inviteCode: String?
    private var userToken: String?
    
    @objc var onActivationSuccess: RCTDirectEventBlock?
    @objc var onActivationFailure: RCTDirectEventBlock?
    @objc var onDeactivationSuccess: RCTDirectEventBlock?
    @objc var onDeactivationFailure: RCTDirectEventBlock?
    
    private var baseProps: [Any?] {
        return [connectionId, suggestedUserEmail, redirectURL, skipConnectionConfiguration]
    }
    
    init() {
        self.connectButton = .init()
        super.init(frame: .zero)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(connectButton)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        
        connectButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        connectButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        connectButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        connectButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    // TODO: Cleanup the setters below. We need to do this so we can initialize the ConnectButtonController with the values below.
    @objc func setOauthCode(_ oauthCode: NSString) {
        if oauthCode as String == self.oauthCode { return }
        
        self.oauthCode = oauthCode as String
        initializeConnectButtonController()
    }
    
    @objc func setInviteCode(_ inviteCode: NSString) {
        if inviteCode as String == self.inviteCode { return }
        
        self.inviteCode = inviteCode as String
        initializeConnectButtonController()
    }
    
    @objc func setUserToken(_ userToken: NSString) {
        if userToken as String == self.userToken { return }
        
        self.userToken = userToken as String
        initializeConnectButtonController()
    }
    
    @objc func setConnectionId(_ connectionId: NSString) {
        if connectionId as String == self.connectionId { return }
        
        self.connectionId = connectionId as String
        initializeConnectButtonController()
    }
    
    @objc func setSuggestedUserEmail(_ suggestedUserEmail: NSString) {
        if suggestedUserEmail as String == self.suggestedUserEmail { return }
        
        self.suggestedUserEmail = suggestedUserEmail as String
        initializeConnectButtonController()
    }
    
    @objc func setRedirectURL(_ redirectURL: NSString) {
        // TODO: Add validation here
        self.redirectURL = URL(string: redirectURL as String)
        initializeConnectButtonController()
    }
    
    @objc func setSkipConnectionConfiguration(_ skipConnectionConfiguration: Bool) {
        self.skipConnectionConfiguration = skipConnectionConfiguration
        initializeConnectButtonController()
    }

    private func initializeConnectButtonController() {
        if baseProps.allSatisfy({ value in
            return value != nil
        }) {
            self.credentialProvider = RCTConnectButtonCredentialProvider(inviteCode: inviteCode, oauthCode: oauthCode, userToken: userToken)
            // TODO: Lots of unwrapping, how can this be made better
            self.connectButtonController = .init(
                connectButton: connectButton,
                connectionConfiguration: .init(
                    connectionId: connectionId!,
                    suggestedUserEmail: suggestedUserEmail!,
                    credentialProvider: RCTConnectButtonCredentialProvider(
                        inviteCode: inviteCode,
                        oauthCode: oauthCode,
                        userToken: userToken),
                    redirectURL: redirectURL!,
                    skipConnectionConfiguration: skipConnectionConfiguration!
                ),
                delegate: self
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RCTConnectButtonWrapper: ConnectButtonControllerDelegate {
    func presentingViewController(for connectButtonController: ConnectButtonController) -> UIViewController {
        // TODO: This is prone to failure. Can we change it?
        return (window?.rootViewController)!
    }
    
    func connectButtonController(_ connectButtonController: ConnectButtonController,
                                 didFinishActivationWithSuccess activation: ConnectionActivation) {
        guard let onActivationSuccess = onActivationSuccess else { return }
        let data = activation.toJSON() as [AnyHashable : Any]
        onActivationSuccess(data)
    }
    
    func connectButtonController(_ connectButtonController: ConnectButtonController,
                                 didFinishActivationWithFailure error: NSError) {
        guard let onActivationFailure = onActivationFailure else { return }
        let data = error.toJSON() as [AnyHashable : Any]
        onActivationFailure(data)
    }
    
    func connectButtonController(_ connectButtonController: ConnectButtonController,
                                 didFinishDeactivationWithSuccess connection: Connection) {
        guard let onDeactivationSuccess = onDeactivationSuccess else { return }
        let data = connection.toJSON() as [AnyHashable : Any]
        onDeactivationSuccess(data)
    }
    
    func connectButtonController(_ connectButtonController: ConnectButtonController,
                                 didFinishDeactivationWithFailure error: NSError) {
        guard let onDeactivationFailure = onDeactivationFailure else { return }
        let data = error.toJSON() as [AnyHashable : Any]
        onDeactivationFailure(data)
    }
    
    func webAuthenticationPresentationAnchor() -> UIWindow {
        // TODO: This feels clunky, can this be changed?
        return window!
    }
}

@objc (RCTConnectButtonViewManager)
class RCTConnectButtonViewManager: RCTViewManager {
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    override func view() -> UIView! {
        return RCTConnectButtonWrapper()
    }
}
