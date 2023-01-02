//
//  FirstViewController.swift
//  RootViewControllerChange
//
//  Created by 김지태 on 2023/01/02.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func rootViewChange(_ sender: Any) {
        RootViewControllerChange().changeRootViewController(currentViewController: self, newStoryboard: "Main", nextViewController: "SecondViewController", animation: false)
    }
}
