//
//  ViewController.swift
//  FcmTopic
//
//  Created by 김지태 on 2023/06/10.
//

import UIKit
import FirebaseMessaging

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Messaging.messaging().subscribe(toTopic: "kimjitae") { error in
            if let error = error {
                print("구독 실패: \(error.localizedDescription)")
            } else {
                print("구독 성공")
            }
        }
    }
}

