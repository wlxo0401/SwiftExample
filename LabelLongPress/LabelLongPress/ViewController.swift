//
//  ViewController.swift
//  LabelLongPress
//
//  Created by 김지태 on 2023/01/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        // label longpress
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.topAddressLabelCopy))
        self.label.addGestureRecognizer(longGesture)
        self.label.isUserInteractionEnabled = true
    }
    @objc private func topAddressLabelCopy() {
        print(" H I ")
    }

}

