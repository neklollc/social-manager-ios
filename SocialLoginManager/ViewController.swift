//
//  ViewController.swift
//  SocialLoginManager
//
//  Created by Yaroslav on 17/11/15.
//  Copyright © 2015 Yaroslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func facebookLogin(sender: UIButton) {
        SocialLoginManager.sharedInstance.facebookLogInWithReadPermissions(["public_profile"], fromViewController: self, handler: { (result) -> Void in
                print(result.token.appID)
            }) { (error) -> Void in
                print("Login error: %@", error.localizedDescription)
        }
    }
    
    @IBAction func vkontakteLogin(sender: UIButton) {
        SocialLoginManager.sharedInstance.vkontakteLogInWithReadPermissions([VK_PER_AUDIO], fromViewController: self, handler: { (token) -> Void in
                print(token!.accessToken)
            })
            { (error) -> Void in
                print("Login error: %@", error!.localizedDescription)
        }
    }
    
    @IBAction func twitterLogin(sender: UIButton) {
        SocialLoginManager.sharedInstance.twitterLogIn(self, handler:
            { (session) -> Void in
                if let session = session {
                    print(session.authToken)
                }
            })
            { (error) -> Void in
                if let error = error {
                    print("Login error: %@", error.localizedDescription)
                }
        }
    }
}

