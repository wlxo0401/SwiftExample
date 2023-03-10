//
//  SecondViewController.swift
//  CustomToastView
//
//  Created by 김지태 on 2023/03/06.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func toastButtonAction(_ sender: Any) {
        
        
        
        let toastView = UIView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true

        let messageLabel = UILabel()
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
        messageLabel.text = "Your message goes here"

        toastView.addSubview(messageLabel)
        
        
        guard let window = UIApplication.shared.windows.last else { return }

        toastView.frame = CGRect(x: 0, y: 0, width: window.frame.width * 0.8, height: 80)
        toastView.center = window.center
        messageLabel.frame = CGRect(x: 16, y: 16, width: toastView.frame.width - 32, height: toastView.frame.height - 32)

        window.addSubview(toastView)
        
        
        UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
            toastView.alpha = 0
        }, completion: { _ in
            toastView.removeFromSuperview()
        })
        
        
    }
    
    
}
