//
//  RootViewChange.swift
//  RootViewControllerChange
//
//  Created by 김지태 on 2023/01/02.
//

import Foundation
import UIKit



class RootViewControllerChange {
    //MARK: - UIWindow의 rootViewController를 변경하여 화면전환
    internal func changeRootViewController(currentViewController: UIViewController, newStoryboard: String = "Main", nextViewController: String, animation: Bool = true) {
        
        let newStoryboard = UIStoryboard(name: newStoryboard, bundle: nil)
        let newViewController = newStoryboard.instantiateViewController(identifier: nextViewController)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = newViewController
            if animation {
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
            }
        } else {
            newViewController.modalPresentationStyle = .overFullScreen
            currentViewController.present(newViewController, animated: true, completion: nil)
        }
        
    }
}
