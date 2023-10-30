//
//  AppVersionCheck.swift
//  AppStoreVersionCheck
//
//  Created by 김지태 on 10/30/23.
//

import Foundation

struct AppVersionCheck {
    static func isNeedUpdate(completion: @escaping (Bool) -> Void) {
        let localVersion = self.checkAppVersion()
        
        self.checkStoreVersion { appStoreVersion in
            if let storeVersion = appStoreVersion {
                let needUpdate = localVersion < storeVersion
                completion(needUpdate)
            } else {
                // 앱 스토어 버전을 가져오지 못한 경우에도 업데이트가 필요하지 않다고 처리합니다.
                completion(false)
            }
        }
    }
    
    static func checkStoreVersion(completion: @escaping (String?) -> Void) {
        
        guard let info = Bundle.main.infoDictionary,
        let identifier = info["CFBundleIdentifier"] as? String else {
            return completion(nil)
        }
        
        print("받아온 번들 : \(identifier)")
        
        guard let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=\(identifier)") else {
            return completion(nil)
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  !results.isEmpty,
                  let appStoreVersion = results[0]["version"] as? String else {
                print("checkStoreVersion : 0")
                
                return completion(nil)
            }
            print("checkStoreVersion : \(appStoreVersion)")
            return completion(appStoreVersion)
        }
        
        task.resume()
    }
    
    static func checkAppVersion() -> String {
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String else {
            print("checkAppVersion : 0")
            return "0"
        }
        print("checkAppVersion : \(currentVersion)")
        return currentVersion
    }
}
