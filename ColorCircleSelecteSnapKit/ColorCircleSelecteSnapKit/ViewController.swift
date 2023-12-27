//
//  ViewController.swift
//  ColorCircleSelecteSnapKit
//
//  Created by 김지태 on 12/27/23.
//

import UIKit
import SnapKit


enum ColorButton: Int {
    case red = 0
    case blue = 1
    case orange = 2
}

class ViewController: UIViewController {
    
    lazy var redCircle: UIView = {
        let outView: UIView = UIView()
        outView.clipsToBounds = true
        outView.backgroundColor = .systemGray
        
        let inView: UIView = {
            let view: UIView = UIView()
            view.clipsToBounds = true
            view.backgroundColor = .red
            view.layer.cornerRadius = 42
            return view
        }()
        
        let button: UIButton = {
            let button: UIButton = UIButton()
            button.addAction(UIAction { _ in
                self.selectedCircle(color: ColorButton.red)
            }, for: .touchUpInside)
            return button
        }()
        
        
        outView.addSubview(inView)
        outView.addSubview(button)
        
        inView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
        return outView
    }()
    
    lazy var blueCircle: UIView = {
        let outView: UIView = UIView()
        outView.clipsToBounds = true
        outView.backgroundColor = .systemGray
        
        let inView: UIView = {
            let view: UIView = UIView()
            view.clipsToBounds = true
            view.backgroundColor = .blue
            view.layer.cornerRadius = 42
            return view
        }()
        
        let button: UIButton = {
            let button: UIButton = UIButton()
            button.addAction(UIAction { _ in
                self.selectedCircle(color: ColorButton.blue)
            }, for: .touchUpInside)
            return button
        }()
        
        
        outView.addSubview(inView)
        outView.addSubview(button)
        
        inView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
        return outView
    }()
    
    lazy var orangeCircle: UIView = {
        let outView: UIView = UIView()
        outView.clipsToBounds = true
        outView.backgroundColor = .systemGray
        
        let inView: UIView = {
            let view: UIView = UIView()
            view.clipsToBounds = true
            view.backgroundColor = .orange
            view.layer.cornerRadius = 42
            return view
        }()
        
        let button: UIButton = {
            let button: UIButton = UIButton()
            button.addAction(UIAction { _ in
                self.selectedCircle(color: ColorButton.orange)
            }, for: .touchUpInside)
            return button
        }()
        
        
        outView.addSubview(inView)
        outView.addSubview(button)
        
        inView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
        return outView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setUI()
    }

    private func setUI() {
        self.view.addSubview(self.redCircle)
        self.view.addSubview(self.blueCircle)
        self.view.addSubview(self.orangeCircle)
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.redCircle.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        self.redCircle.layer.cornerRadius = 50
        
        self.blueCircle.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.redCircle.snp.trailing).offset(8)
        }
        
        self.blueCircle.layer.cornerRadius = 50
        
        self.orangeCircle.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(self.redCircle.snp.leading).offset(-8)
        }
        
        self.orangeCircle.layer.cornerRadius = 50
    }
    
    private func selectedCircle(color: ColorButton) {
        switch color {
        case .red:
            self.redCircle.backgroundColor = .green
            self.blueCircle.backgroundColor = .gray
            self.orangeCircle.backgroundColor = .gray
        case .blue:
            self.redCircle.backgroundColor = .gray
            self.blueCircle.backgroundColor = .green
            self.orangeCircle.backgroundColor = .gray
        case .orange:
            self.redCircle.backgroundColor = .gray
            self.blueCircle.backgroundColor = .gray
            self.orangeCircle.backgroundColor = .green
        }
    }
}

