//
//  ViewController.swift
//  VersionCheckTest
//
//  Created by 김지태 on 2023/05/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var oen: UILabel!
    
    @IBOutlet weak var two: UILabel!
    
    @IBOutlet weak var three: UILabel!
    
    
    @IBOutlet weak var four: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.oen.text = "앱 버전 : \(AppVersionCheck().checkAppVersion())"
        self.two.text = "스토어 버전 : \(AppVersionCheck().checkStoreVersion())"
        
        
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String else {return}
        
        self.three.text = "기존 방법 앱 버전 : \(version)"
        self.four.text = "기존 방법 앱 빌드 : \(build)"
    }
}



class AppVersionCheck {
    
    func isNeedUpdate() -> Bool {
        return self.checkAppVersion() < self.checkStoreVersion()
    }
    
    func checkStoreVersion() -> String {
        /*
        [앱 버전 정보 확인 방법]
        1. 앱 스토어 사이트 접속 : https://www.apple.com/kr/app-store/
        2. 버전 정보를 확인하려는 앱 검색 : ex) 크롬
        3. 앱 아이디 확인 실시 : https://apps.apple.com/kr/app/google-chrome/id535886823
        */
        
        
        guard let info = Bundle.main.infoDictionary,
        let identifier = info["CFBundleIdentifier"] as? String else {
            return "0"
        }
        
        
        guard let url = URL(string: "http://itundes.apple.com/kr/lookup?bundleId=\(identifier)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              let appStoreVersion = results[0]["version"] as? String else {
            print("checkStoreVersion : 0")
            return "0"
        }
        print("checkStoreVersion : \(appStoreVersion)")
        return appStoreVersion // 리턴 값 반환 실시
    }
    
    func checkAppVersion() -> String {
        guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String else {
            return "0"
        }
        print("checkAppVersion : \(currentVersion)")
        return currentVersion
    }
}
