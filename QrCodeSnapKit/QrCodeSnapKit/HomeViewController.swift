//
//  HomeViewController.swift
//  QrCodeSnapKit
//
//  Created by 김지태 on 12/27/23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    lazy var pushButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .orange
        button.setTitle("화면 이동", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addAction(UIAction { _ in
            let vc = QrReaderViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.setUI()
    }

    
    // UI 셋팅
    private func setUI() {
        
        // 버튼
        self.view.addSubview(self.pushButton)
        
        // 제약 조건
        self.setUpConstraints()
    }
    
    // 제약 조건
    private func setUpConstraints() {
        self.pushButton.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.center.equalToSuperview()
        }
    }

}
