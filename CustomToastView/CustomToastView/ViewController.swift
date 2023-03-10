//
//  ViewController.swift
//  CustomToastView
//
//  Created by 김지태 on 2023/03/06.
//

import UIKit
import Toaster


class ViewController: UIViewController {

    let toastView = UIView()
//    var appWindow = UIWindow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       print("viewDidLoad")
        self.toastView.backgroundColor = UIColor.black
        self.toastView.layer.cornerRadius = 10
        self.toastView.clipsToBounds = true
        
        guard let window = UIApplication.shared.windows.last else { return }
        
//        if let window = UIApplication.shared.windows.last  {
//            self.appWindow = window
//        }
        
        
        // Register for the notification
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidBecomeKey(_:)), name: UIWindow.didBecomeVisibleNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unregister for the notification
        NotificationCenter.default.removeObserver(self, name: UIWindow.didBecomeKeyNotification, object: nil)

    }
    
    // Define the selector function to handle the notification
    @objc func windowDidBecomeKey(_ notification: Notification) {
        // Do something when the window becomes the key window
        
        print("새 창 열림")
        self.toastView.window?.windowLevel = UIWindow.Level.alert + 1

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.windows.last
        //This is better

        let viewToShow = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100.0))

        viewToShow.backgroundColor = UIColor.black
        

        window?.addSubview(viewToShow)
        viewToShow.window?.windowLevel = UIWindow.Level.statusBar + 1
    }
    
    
    
    @IBAction func pushButtonAction(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func presentButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func fullScreenButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func overFullScreenButtonAction(_ sender: Any) {
        
        let secondBox = UIView()

         secondBox.backgroundColor = UIColor.red
         secondBox.layer.cornerRadius = 10
         secondBox.clipsToBounds = true
        secondBox.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: 80)
        secondBox.center = self.view.center
        self.view.addSubview(secondBox)
        
        self.view.bringSubviewToFront(secondBox)
        
//        UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
//            secondBox.alpha = 0
//        }, completion: { _ in
//            secondBox.removeFromSuperview()
//        })

    }
    
    
    @IBAction func toastButtonAction(_ sender: Any) {
        guard let window = UIApplication.shared.windows.last else { return }
        
        self.toastView.alpha = 1


        let messageLabel = UILabel()
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
        messageLabel.text = "Your message goes here"

        toastView.addSubview(messageLabel)


        toastView.frame = CGRect(x: 0, y: 0, width: window.frame.width * 0.8, height: 80)
        toastView.center = window.center
        messageLabel.frame = CGRect(x: 16, y: 16, width: toastView.frame.width - 32, height: toastView.frame.height - 32)

        window.addSubview(toastView)

//        UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
//            self.toastView.alpha = 0
//        }, completion: { _ in
//            self.toastView.removeFromSuperview()
//        })
    }
    
}

