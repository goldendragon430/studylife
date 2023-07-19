import UIKit
import Flutter
import FirebaseCore
import Intercom

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     // FirebaseApp.configure()
     // Intercom.setApiKey("ios_sdk-8508e92cd78cb38dcce0ed9590f243b9b697ebe4", forAppId: "agyxm8qz")
//      return MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
