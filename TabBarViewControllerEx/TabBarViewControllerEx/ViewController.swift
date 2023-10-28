//
//  ViewController.swift
//  TabBarViewControllerEx
//
//  Created by 김지태 on 10/28/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ddd(_ sender: Any) {
        guard let d = self.storyboard?.instantiateViewController(withIdentifier: "DDViewController") as? DDViewController else { return }
        self.navigationController?.pushViewController(d, animated: true)
    }
    
}

