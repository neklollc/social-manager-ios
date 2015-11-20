# social-manager-ios
SocialManager-iOS

Add SafariServices.framework library into your project

Vkontakte 

1) SDk http://github.com/VKCOM/vk-ios-sdk

	Add VKSdk.framework and VKSdkResources.bundle libraries into your project

	If app use Swift, create Bridging Header (https://bohemianpolymorph.wordpress.com/2014/07/11/manually-adding-a-swift-bridging-header/)
	with 
	#import <VKSdk/VKSdk.h>

2) Create VK App http://vk.com/apps?act=manage. Standalone app

3) Info.plist:
	a) add to CFBundleURLTypes
		<dict>
			<key>CFBundleURLName</key>
			<string>vk1111111</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>vk1111111</string>
			</array>
		</dict>
	
	1111111 - app_ID
	
	б) add to LSApplicationQueriesSchemes
		<string>vk</string>
		<string>vk-share</string>
		<string>vkauthorize</string>
		
	в) add to  NSAppTransportSecurity - NSExceptionDomains
		<key>vk.com</key>
		<dict>
			<key>NSExceptionAllowsInsecureHTTPLoads</key>
			<true/>
			<key>NSExceptionRequiresForwardSecrecy</key>
			<false/>
			<key>NSIncludesSubdomains</key>
			<true/>
		</dict>
		
3) AppDelegate 

	//iOS 9 workflow
	func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    	VKSdk.processOpenURL(url, fromApplication: options["UIApplicationOpenURLOptionsSourceApplicationKey"] as! String)
             
  		return true
	}
	
	//iOS 8 and lower
	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) 	-> Bool {
    	VKSdk.processOpenURL(url, fromApplication: sourceApplication)
    
		return true;
	}
	
4) in SocialLoginManager class change vkontakteAppID to your appID

________________________

Twitter 

1) Use function Twitter in Fabric. Follow the instructions

2) AppDelegate

	add in applicationdidFinishLaunchingWithOptions method
	
		Fabric.with([Twitter.self])

_________________________

Facebook

Подготовка 

SDK - https://developers.facebook.com/docs/ios

Add FBSDKCoreKit, FBSDKLoginKit, FBSDKShareKit libraries into your project

1) Create Facebook App https://developers.facebook.com/apps/

2) Info.plist:

	a)Add 
	<key>FacebookAppID</key>
	<string>111111111111111</string>
	<key>FacebookDisplayName</key>
	<string>SocialLoginManager</string>
	
	б)add in LSApplicationQueriesSchemes
		<string>fbauth2</string>
	
	в)add in CFBundleURLTypes
	<dict>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>fb111111111111111</string>
		</array>
	</dict>
	
	г)add in NSAppTransportSecurity - NSExceptionDomains
	<key>facebook.com</key>
	    <dict>
	      <key>NSIncludesSubdomains</key> <true/>        
	      <key>NSThirdPartyExceptionRequiresForwardSecrecy</key> <false/>
	    </dict>
	    <key>fbcdn.net</key>
	    <dict>
	      <key>NSIncludesSubdomains</key> <true/>
	      <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>  <false/>
	    </dict>
	    <key>akamaihd.net</key>
	    <dict>
	      <key>NSIncludesSubdomains</key> <true/>
	      <key>NSThirdPartyExceptionRequiresForwardSecrecy</key> <false/>
	    </dict>
	  </dict>
	

111111111111111 - AppID from site
SocialLoginManager - AppName from site

3) AppDelegate
 
	//iOS 9 workflow
	func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    	FBSDKApplicationDelegate.sharedInstance().application(app, openURL: url, sourceApplication: 			options["UIApplicationOpenURLOptionsSourceApplicationKey"] as! String, annotation: nil)
             
  		return true
	}
	
	//iOS 8 and lower
	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) 	-> Bool {
    	 FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: 			annotation)
    
		return true;
	}
	
	func applicationDidBecomeActive(application: UIApplication) {
		FBSDKAppEvents.activateApp()
	}
	
	в applicationdidFinishLaunchingWithOptions добавить метод 
	
	FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
	

