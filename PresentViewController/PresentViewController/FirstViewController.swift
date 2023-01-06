//
//  ViewController.swift
//  PresentViewController
//
//  Created by 김지태 on 2023/01/06.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func presentButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

