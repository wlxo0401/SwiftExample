//
//  ViewController.swift
//  PushViewControllerByCode
//
//  Created by 김지태 on 2023/01/04.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushButtonAction(_ sender: Any) {
        
        guard let VcName = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        self.navigationController?.pushViewController(VcName, animated: true)
        
    }
}

