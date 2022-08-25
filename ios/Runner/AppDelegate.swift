import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyC7wTJpXiHATlL2exVvAOcmZFtgvmDHwL8")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
