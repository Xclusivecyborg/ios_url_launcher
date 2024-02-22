import UIKit
import Flutter
import SwiftUI




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

@Environment(\.openURL) var openUrl

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {   

    let controller : FlutterViewController =
    window?.rootViewController as! FlutterViewController

    let METHOD_CHANNEL = "sample/methodchannel"

    let launchUrlChannel =
    FlutterMethodChannel(
     name: METHOD_CHANNEL,
     binaryMessenger: controller.binaryMessenger
    )

      launchUrlChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if (call.method == "launchURL") {
                let args = call.arguments as? [String: String]
                let url = args?["url"] as? String
                self.launchUrl(url: url)
            }
        })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


   func launchUrl(url: String?)  {
        guard let link = url,
              let url = URL(string: link)else {
            return
        }
        openUrl(url)
    }
    
}
