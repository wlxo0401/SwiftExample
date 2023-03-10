//
//  AppDelegate.swift
//  CustomToastView
//
//  Created by 김지태 on 2023/03/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        // 1. 새로운 UIWindow 인스턴스를 만듭니다.
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        
        // 2. UIWindow 인스턴스의 rootViewController를 설정합니다.
        let viewController = ViewController()
        newWindow.rootViewController = viewController
        
        // 3. UIWindow 인스턴스를 keyWindow로 만듭니다.
        newWindow.makeKeyAndVisible()
        
        // 4. 새 UIWindow 인스턴스를 AppDelegate에 설정해줍니다.
        self.window = newWindow
        
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


class MyWindow: UIWindow {
    var topView: UIView? {
        didSet {
            if let topView {
                // Make sure the view is actually assigned to this window
                if topView.window === self {
                    bringSubviewToFront(topView)
                } else {
                    self.topView = nil
                }
            }
        }
    }

    override func addSubview(_ view: UIView) {
        super.addSubview(view)

        if let topView {
            bringSubviewToFront(topView)
        }
    }

    override func willRemoveSubview(_ subview: UIView) {
        if let topView, subview === topView {
            self.topView = nil
        }

        super.willRemoveSubview(subview)
    }

    override func bringSubviewToFront(_ view: UIView) {
        super.bringSubviewToFront(view)

        if let topView, view !== topView {
            super.bringSubviewToFront(topView)
        }
    }
}
