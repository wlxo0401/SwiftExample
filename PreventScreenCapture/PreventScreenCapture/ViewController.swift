//
//  ViewController.swift
//  PreventScreenCapture
//
//  Created by 김지태 on 2023/07/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var privateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.privateView.preventCapture()
    }

    @IBAction func buttonText(_ sender: Any) {
        print("bye")
    }
    @IBAction func button(_ sender: Any) {
        print("Hi")
    }
    
    @IBAction func ddddd(_ sender: Any) {
        print("dfkdfjdkj")
    }
}


extension UIView {
    func preventCapture() {
        DispatchQueue.main.async {
            let textField = UITextField()
            textField.isSecureTextEntry = true

            self.addSubview(textField)
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

            textField.layer.removeFromSuperlayer()
            self.layer.superlayer?.insertSublayer(textField.layer, at: 1)
            textField.layer.sublayers?.last?.addSublayer(self.layer)
        }
    }
}
