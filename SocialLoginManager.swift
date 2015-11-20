//
//  SocialLoginManager.swift
//  SocialLoginManager
//
//  Created by Yaroslav on 19/11/15.
//  Copyright © 2015 Yaroslav. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit

public class SocialLoginManager: NSObject {
    
    static let sharedInstance = SocialLoginManager()
    
    let vkontakteAppID = "1234567"
    
    public typealias SocialLoginManagerFacevookSuccessBlock = (FBSDKLoginManagerLoginResult!) -> Void
    public typealias SocialLoginManagerFacevookErrorBlock = (NSError!) -> Void
    
    public typealias SocialLoginManagerTwitterSuccessBlock = (TWTRSession?) -> Void
    public typealias SocialLoginManagerTwitterErrorBlock = (NSError?) -> Void
    
    public typealias SocialLoginManagerVkontakteSuccessBlock = (VKAccessToken?) -> Void
    public typealias SocialLoginManagerVkontakteErrorBlock = (NSError?) -> Void
    
    private var viewControllerForVkontakteAuth:UIViewController?;
    private var vkontakteSuccessBlock:SocialLoginManagerVkontakteSuccessBlock?;
    private var vkontakteErrorBlock:SocialLoginManagerVkontakteErrorBlock?;

    override init() {
        super.init()
        let VKSdkInstance = VKSdk.initializeWithAppId(vkontakteAppID)
        VKSdkInstance.registerDelegate(self)
        VKSdkInstance.uiDelegate = self
    }
    
    public func facebookLogInWithReadPermissions(permissions: [AnyObject]!, fromViewController: UIViewController!, handler: SocialLoginManagerFacevookSuccessBlock?, error:SocialLoginManagerFacevookErrorBlock?) {
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logInWithReadPermissions(permissions, fromViewController: fromViewController)
            { (requestTokenResult, requestError) -> Void in
            if let requestTokenResult = requestTokenResult, handler = handler {
                handler(requestTokenResult)
            } else if let error = error, requestError = requestError {
                error(requestError)
            }
        }
    }
    
    public func facebookCurrentToken() -> FBSDKAccessToken! {
        return FBSDKAccessToken.currentAccessToken()
    }
    
    public func twitterLogIn(fromViewController: UIViewController!, handler: SocialLoginManagerTwitterSuccessBlock?, error:SocialLoginManagerTwitterErrorBlock?) {
        Twitter.sharedInstance().logInWithViewController(fromViewController) { (sessionResult, sessionError) -> Void in
            if let sessionResult = sessionResult, handler = handler {
                handler(sessionResult)
            } else if let error = error, sessionError = sessionError {
                error(sessionError)
            }
        }
    }
    
    public func vkontakteLogInWithReadPermissions(permissions: [AnyObject]!, fromViewController: UIViewController!, handler: SocialLoginManagerVkontakteSuccessBlock?, error:SocialLoginManagerVkontakteErrorBlock?) {
        viewControllerForVkontakteAuth = fromViewController
        if let handler = handler {
            vkontakteSuccessBlock = handler
        }
        if let error = error {
            vkontakteErrorBlock = error
        }
        
        VKSdk.wakeUpSession(permissions) { (VKstate, VKerror) -> Void in
            switch VKstate {
            case .Initialized:
                VKSdk.authorize(permissions, withOptions: .DisableSafariController)
                break
            case .Authorized:
                if let token = VKSdk.accessToken(), handler = handler {
                    handler(token)
                }
                break
            default:
                if let error = error {
                    error(VKerror)
                }
            }
        }
    }

    public func twitterCurrentSession() -> TWTRAuthSession? {
        return Twitter.sharedInstance().sessionStore.session()
    }
    
    public func vkontakteCurrentToken() -> VKAccessToken? {
        return VKSdk.accessToken()
    }
}
    
    
//MARK: - VKSdkDelegate
extension SocialLoginManager: VKSdkDelegate {
    
    public func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        if let error = result.error, vkontakteErrorBlock = vkontakteErrorBlock {
            vkontakteErrorBlock(error)
        } else if let token = result.token, vkontakteSuccessBlock = vkontakteSuccessBlock {
            vkontakteSuccessBlock(token)
        }
    }
    
    public func vkSdkUserAuthorizationFailed() {
        let vkError = VKError(code: 400)
        vkError.errorMessage = "User Authorization Failed"
        let error = NSError(vkError: vkError)
        if let vkontakteErrorBlock = vkontakteErrorBlock {
            vkontakteErrorBlock(error)
        }
    }
}
    

//MARK: - VKSdkUIDelegate
extension SocialLoginManager: VKSdkUIDelegate {
    
    public func vkSdkShouldPresentViewController(controller: UIViewController!) {
        guard let vc = viewControllerForVkontakteAuth else {
            return
        }
        vc.presentViewController(controller, animated: true, completion: nil)
    }
    
    public func vkSdkNeedCaptchaEnter(captchaError: VKError) {
        let captchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        guard let vc = viewControllerForVkontakteAuth else {
            return
        }
        vc.presentViewController(captchaViewController, animated: true, completion: nil)
    }
}