//
//  ViewController.swift
//  Call
//
//  Created by 김지태 on 2023/04/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func callButton(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://01096541070") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }

    }
    
}

