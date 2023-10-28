//
//  LoginViewController.swift
//  CoordinatorPattern
//
//  Created by 김지태 on 10/27/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    var didSendEventClosure: ((LoginViewController.Event) -> Void)?

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
                
        self.view.addSubview(loginButton)

        self.loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.loginButton.widthAnchor.constraint(equalToConstant: 200),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.loginButton.addTarget(self, action: #selector(self.didTapLoginButton(_:)), for: .touchUpInside)
    }
            
    deinit {
        print("LoginViewController deinit")
    }

    @objc private func didTapLoginButton(_ sender: Any) {
        
        if nil != self.didSendEventClosure {
            self.didSendEventClosure?(.login)
        } else {
            print("nil")
        }
        
        
    }
}

extension LoginViewController {
    enum Event {
        case login
    }
}
