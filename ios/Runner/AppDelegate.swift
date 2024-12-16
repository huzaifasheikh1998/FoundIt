import UIKit
import Flutter
import FirebaseCore
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FirebaseApp.configure()
    self.window.makeSecure()
    GeneratedPluginRegistrant.register(with: self)
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension UIWindow {
  func makeSecure() {
      let field = UITextField()
      field.isSecureTextEntry = true
      self.addSubview(field)
      field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      self.layer.superlayer?.addSublayer(field.layer)
      field.layer.sublayers?.first?.addSublayer(self.layer)
    }
  }