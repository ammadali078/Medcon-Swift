//
//  AppDelegate.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 21/06/2021.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import FirebaseCore
import FirebaseMessaging
import FirebaseDatabase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var ref: DatabaseReference!
//    var analytics: Analytics? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        
        UNUserNotificationCenter.current().delegate = self
        
        application.registerForRemoteNotifications()
        
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true // Keyboard Manager
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40.0
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UIApplication.shared.registerForRemoteNotifications()
        
        self.registerForPushNotifications()
        
        
        ref = Database.database().reference()
        
        
        ref.child("version/ios/-NccAkdfQBlTQfxUCZrL").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let score = value?["version"] as? String ?? ""
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            
            if score == appVersion {
                
                print("ali")
            }else {
                
//                CommonUtils.showMsgDialogWithupdate(showingPopupOn: self, withTitle: "Medcon", withMessage: "There is an Update available! Please update to use this App", onOkClicked: {() in
//
//                })
                
                var alertController = UIAlertController(title: "Medcon", message: "There is an Update available! Please update to use this App", preferredStyle: .actionSheet)
                var okAction = UIAlertAction(title
                                             : "Update", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    if let url = URL(string: "itms-apps://itunes.apple.com/app/medcon-2019/id1387008793") {
                        UIApplication.shared.open(url)
                      
                    }
                }
                alertController.addAction(okAction)
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                
                
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        //        registerForPushNotifications()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
     func applicationDidBecomeActive(_ application: UIApplication) {
         // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//         self.hasLocationPermission()
         ref = Database.database().reference()
         
         
         ref.child("version/ios/-NccAkdfQBlTQfxUCZrL").observeSingleEvent(of: .value, with: { (snapshot) in
             // Get user value
             let value = snapshot.value as? NSDictionary
             let score = value?["version"] as? String ?? ""
             let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
             
             if score == appVersion {
                 
                 print("ali")
             }else {
                 
 //                CommonUtils.showMsgDialogWithupdate(showingPopupOn: self, withTitle: "Medcon", withMessage: "There is an Update available! Please update to use this App", onOkClicked: {() in
 //
 //                })
                 
                 var alertController = UIAlertController(title: "Medcon", message: "There is an Update available! Please update to use this App", preferredStyle: .actionSheet)
                 var okAction = UIAlertAction(title
                                              : "Update", style: UIAlertAction.Style.default) {
                     UIAlertAction in
                     if let url = URL(string: "itms-apps://itunes.apple.com/app/medcon-2019/id1387008793") {
                         UIApplication.shared.open(url)
                       
                     }
                 }
                 alertController.addAction(okAction)
                 self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                 
                 
             }
             
             // ...
         }) { (error) in
             print(error.localizedDescription)
         }
         
         
     }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func registerForPushNotifications() {
        //1
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                    print("Permission granted: \(granted)")
                    guard granted else { return }
                    self?.getNotificationSettings()
                }    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // sometimes this function didRegisterForRemoteNotificationsWithDeviceToken is not called
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        print(deviceTokenString)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register: \(error)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([[.alert, .badge, .sound]])
    }
    
    //    func userNotificationCenter(_ center: UNUserNotificationCenter,
    //                                didReceive response: UNNotificationResponse,
    //                                withCompletionHandler completionHandler: @escaping () -> Void) {
    //      let userInfo = response.notification.request.content.userInfo
    //
    //      Messaging.messaging().appDidReceiveMessage(userInfo)
    //
    //      let storyBoard: UIStoryboard = UIStoryboard(name: "notification", bundle: nil)
    //            let presentViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationViewScene") as! NotificationViewController
    //
    ////            presentViewController.yourDict = userInfo //pass userInfo data to viewController
    //            self.window?.rootViewController = presentViewController
    //            presentViewController.present(presentViewController, animated: true, completion: nil)
    //
    //
    //
    //      completionHandler()
    //    }
    
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //
    //        let storyboard = UIStoryboard(name: "notification", bundle: nil)
    //
    //        // instantiate the view controller from storyboard
    //        if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "NotificationViewScene") as? NotificationViewController {
    //
    //            // set the view controller as root
    //            self.window?.rootViewController = conversationVC
    //        }
    //
    //        // tell the app that we have finished processing the user’s action / response
    //        completionHandler()
    //    }
    
    
    
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler(.noData)
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    // This function will be called right after user tap on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //      let mainStoryboard:UIStoryboard = UIStoryboard(name: "notification", bundle: nil)
        //               let homePage = mainStoryboard.instantiateViewController(withIdentifier: "NotificationViewScene") as! NotificationViewController
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "notification", bundle: nil)
        let presentViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationViewScene") as! NotificationViewController
        UIApplication.shared.windows.first?.rootViewController?.present(presentViewController, animated: true, completion: nil)
        
        //      let vc = UIStoryboard.init(name: "notification", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationViewScene") as? NotificationViewController
        //      let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //      appDelegate.window?.rootViewController?.present(vc!, animated: true)
        
        
        // tell the app that we have finished processing the user’s action / response
        completionHandler()
    }
}




