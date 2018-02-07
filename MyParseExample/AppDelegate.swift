import UIKit
import UserNotifications
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    WallPost.registerSubclass()
    
    let configuration = ParseClientConfiguration {
      $0.applicationId = "stULMLAxhJ7LpQxQLsxL"
      $0.server = "http://mydummy.herokuapp.com/parse"
    }
    Parse.initialize(with: configuration)
    
    /*
    Not using remote notifications
    */
    
    /*
    //1
    let userNotificationCenter = UNUserNotificationCenter.current()
    userNotificationCenter.delegate = self
    
    //2
    userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { accepted, error in
      guard accepted == true else {
        print("User declined remote notifications")
        return
      }
      //3
      application.registerForRemoteNotifications()
    }
    */
    return true
  }
  
  // 1
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let installation = PFInstallation.current()
    installation?.setDeviceTokenFrom(deviceToken)
    installation?.saveInBackground()
  }
  // 2
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    if (error as NSError).code == 3010 {
      print("Push notifications are not supported in the iOS Simulator.")
    } else {
      print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
    }
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler:
    @escaping (UNNotificationPresentationOptions) -> Void) {
    PFPush.handle(notification.request.content.userInfo)
    completionHandler(.alert)
  }
}
