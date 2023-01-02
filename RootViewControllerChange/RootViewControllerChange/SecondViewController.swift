//
//  SecondViewController.swift
//  RootViewControllerChange
//
//  Created by 김지태 on 2023/01/02.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func rootViewChange(_ sender: Any) {
        RootViewControllerChange().changeRootViewController(currentViewController: self, newStoryboard: "Main", nextViewController: "FirstViewController")
    }
}
