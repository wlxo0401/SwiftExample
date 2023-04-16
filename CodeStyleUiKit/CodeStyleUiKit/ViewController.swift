//
//  ViewController.swift
//  CodeStyleUiKit
//
//  Created by 김지태 on 2023/04/16.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.testView)
        self.testView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.testView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.testView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.testView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }


}

