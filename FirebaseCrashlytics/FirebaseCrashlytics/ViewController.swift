//
//  ViewController.swift
//  FirebaseCrashlytics
//
//  Created by 김지태 on 11/3/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 버튼 생성
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Test Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
    }

    // 에러용 버튼
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        let numbers = [0]
        let _ = numbers[1]
    }
}

