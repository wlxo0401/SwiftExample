//
//  AppDelegate.swift
//  GCDWebServerEx
//
//  Created by 김지태 on 11/6/23.
//

import UIKit

// 기기 웹 서버
import GCDWebServer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 웹 서버
    let webServer = GCDWebServer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 웹서버 파일 경로
        let subdir = Bundle.main.resourceURL!.appendingPathComponent("dist").path
        // 웹 서버 셋팅
        self.webServer.addGETHandler(forBasePath: "/",
                                     directoryPath: subdir,
                                     indexFilename: "index.html",
                                     cacheAge: 3600,
                                     allowRangeRequests: true)
        // 웹 서버 실행
        self.webServer.start(withPort: 8889, bonjourName: "GCD Web Server")
        
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

