//
//  ViewController.swift
//  AppStoreVersionCheck
//
//  Created by 김지태 on 10/30/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppVersionCheck.isNeedUpdate { result in
            print("업데이트 필요 여부 : \(result)")
        }
    }
}


