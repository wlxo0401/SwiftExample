//
//  LoginCoordinator.swift
//  CoordinatorPattern
//
//  Created by 김지태 on 10/27/23.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        print("LoginCoordinator: Start")
        self.showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showLoginViewController() {
        print("LoginCoordinator: showLoginViewController")
        let loginVC: LoginViewController = .init()
        loginVC.didSendEventClosure = { [weak self] event in
            print("이거 왜 안되노...")
            self?.finish()
        }
        
        self.navigationController.pushViewController(loginVC, animated: true)
    }
}
