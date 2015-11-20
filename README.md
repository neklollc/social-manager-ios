
## SocialManager-iOS 
(suppoted Facebook, Twitter, Vkontakte)

## How To Get Started

- [Download SocialManager-iOS](https://github.com/neklollc/social-manager-ios/archive/master.zip) and add your project
- Add SafariServices.framework into your project. [See guide.](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/Articles/AddingaLibrarytoaTarget.html)

________________________
## Installation Vkontakte 

####Prepare

- [Download SDK](http://github.com/VKCOM/vk-ios-sdk)
- Add VKSdk.framework and VKSdkResources.bundle into your project
- If app use Swift, create Bridging Header and add #import <VKSdk/VKSdk.h>. [See guide.](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html)
- [Create VK App](http://vk.com/apps?act=manage). Type - Standalone app
- Check permissions list in VKPermissions class in framework

####Modify Info.plist

- add in CFBundleURLTypes 
```
	<dict>
		<key>CFBundleURLName</key>
		<string>vk1234567</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>vk1234567</string>
		</array>
	</dict>
```
	
1234567 - ID application from [VK Developers.](https://vk.com/apps?act=manage)
	
- add in LSApplicationQueriesSchemes
```
	<string>vk</string>
	<string>vk-share</string>
	<string>vkauthorize</string>
```	
- add in NSAppTransportSecurity - NSExceptionDomains
```
	<key>vk.com</key>
	<dict>
		<key>NSExceptionAllowsInsecureHTTPLoads</key>
		<true/>
		<key>NSExceptionRequiresForwardSecrecy</key>
		<false/>
		<key>NSIncludesSubdomains</key>
		<true/>
	</dict>
```
		
####Modify AppDelegate 
```
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
```	
####Modify SocialLoginManager class 

Change vkontakteAppID to ID application from [VK Developers.](https://vk.com/apps?act=manage)

________________________

## Installation Twitter 

At the moment SocialManager-iOS uses Fabric to work with twitter

####Prepare
- If you have not used Fablic yet. You should look at [Getting Started](https://docs.fabric.io/ios/fabric/getting-started.html)
- Use function Twitter in Fabric app. Follow the instructions

####Modify AppDelegate
```
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        Fabric.with([Twitter.self])

        return true
}
```	
_________________________

## Installation Facebook

####Prepare

- [Download SDK](https://developers.facebook.com/docs/ios) 
- [Create Facebook App](https://developers.facebook.com/apps/) 
- Check [permissions list](https://developers.facebook.com/docs/facebook-login/permissions/v2.5)
- Add FBSDKCoreKit, FBSDKLoginKit, FBSDKShareKit into your project

####Modify Info.plist:

- create in Info.plist
```	
	<key>FacebookAppID</key>
	<string>1234567891234567</string>
	<key>FacebookDisplayName</key>
	<string>SocialLoginManager</string>
```		
- add in LSApplicationQueriesSchemes
```	
	<string>fbauth2</string>
```	
	
- add in CFBundleURLTypes
```	
	<dict>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>fb1234567891234567</string>
		</array>
	</dict>
```	
	
- add in NSAppTransportSecurity - NSExceptionDomains
```	
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
```

1234567891234567, SocialLoginManager - AppID and AppName from [Facebook Developers.](https://developers.facebook.com/apps/)

####Modify AppDelegate
```	
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

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
	FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

   	return true
}
```	
	
	
	

