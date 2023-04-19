//
//  ViewController.swift
//  PushStudy
//
//  Created by 김지태 on 2023/04/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.showButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
    }
    
    
    
    @objc private func buttonAction() {
        
        self.bodyLabel.text = self.getCurrentResourceVersion()
        
        
    }

    
    
    // 단말기에 설치된 리소스 버전 저장
    func setCurrentResourceVersion(currentResourceVersion: String) {
        self.defaults.set(currentResourceVersion, forKey: "currentResourceVersion")
    }
    // 단말기에 설치된 리소스 버전 불러오기
    func getCurrentResourceVersion() -> String {
        if let currentResourceVersion = self.defaults.string(forKey: "currentResourceVersion") {
            return currentResourceVersion
        }
        return "내용 없음"
    }

}




