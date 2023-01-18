//
//  ViewController.swift
//  ToastSwiftTest
//
//  Created by 김지태 on 2023/01/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ToastMessageUtils().showToastMessage(currentView: self.view, message: "dfjkdf")
    }


}



class ToastMessageUtils {
    
    //MARK: - 토스트메세지
    // 2022년 11월 07일 김지태
    func showToastMessage(currentView: UIView, message: String) {
        
        // create a new style
        var style = ToastStyle()

        // this is just one of many style options
        style.messageColor = .white
        style.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        style.maxWidthPercentage = 0.9
        

        // present the toast with the new style
        // currentView.makeToast(message, duration: 3.0, position: .bottom, style: style)

        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style
        currentView.makeToast(message) // now uses the shared style

        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true

        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled = false
        
        ToastManager.shared.position = .bottom
        
    }
}
