//
//  AppDelegate.swift
//  MoveToScreenWithFCM
//
//  Created by 김지태 on 2023/04/19.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 1. 푸시 권한 요청
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print(granted)
        }
        
        // Firebase Config
        FirebaseApp.configure()
        
        // 앱 메세지를 받는 Delegate
        UNUserNotificationCenter.current().delegate = self
        // Firebase Delegate
        Messaging.messaging().delegate = self
        // Notification 등록
        application.registerForRemoteNotifications()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}



extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {

    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let firebaseToken = fcmToken ?? ""
        print("firebase token: \(firebaseToken)")
    }

    
    // foreground에서 시스템 푸시를 수신했을 때 해당 메소드가 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("ㅎㅇ")
        completionHandler([.sound, .badge, .banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void ) {
      let userInfo = response.notification.request.content.userInfo
      print(userInfo)
        
        
        
        let application = UIApplication.shared
                
        //앱이 켜져있는 상태에서 푸쉬 알림을 눌렀을 때
//        if application.applicationState == .active {
//            print("푸쉬알림 탭(앱 켜져있음)")
//            UserDefaults.standard.set("푸쉬알림 탭(앱 켜져있음)", forKey: "currentResourceVersion")
//        }
//
//        //앱이 꺼져있는 상태에서 푸쉬 알림을 눌렀을 때
//        if application.applicationState == .inactive {
//          print("푸쉬알림 탭(앱 꺼져있음)")
//            UserDefaults.standard.set("푸쉬알림 탭(앱 꺼져있음)", forKey: "currentResourceVersion")
//        }
        
        
        
        guard
            let aps = userInfo[AnyHashable("aps")] as? NSDictionary,
            let alert = aps["alert"] as? NSDictionary,
            let body = alert["body"] as? String,
            let title = alert["title"] as? String
            else {
                // handle any error here
                return
            }

        guard let data = userInfo[AnyHashable("screen")] as? String else { return }
        
        
        UserDefaults.standard.set(data, forKey: "currentResourceVersion")
        print("Title: \(title) \nBody:\(body) \ndata:\(data)")
        
        
        // 푸시알림 클릭시 화면 이동
        if let apsData = userInfo["aps"] as? [String : AnyObject] {
            if let subtitleData = apsData["subtitle"] as? [String : Any] {
                // 내가 필요한 pidx라는 데이터는 aps > alert > pidx 에 들어있었다.
                print(subtitleData)
            }
        }
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController?.topmostViewController {
            // 최상위 뷰 컨트롤러 사용
            if let navigationController = topViewController.navigationController {
                navigationController.popToRootViewController(animated: true)
            } else {
                topViewController.dismiss(animated: true, completion: {
                    
                    if let topViewController = UIApplication.shared.windows.first?.rootViewController?.topmostViewController {
                        if let navigationController = topViewController.navigationController {
                            navigationController.popToRootViewController(animated: true)
                        }
                    }
                })
            }
        }

      
    }
    
}
extension UIViewController {
    var topmostViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topmostViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topmostViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.topmostViewController
        } else {
            return self
        }
    }
}
