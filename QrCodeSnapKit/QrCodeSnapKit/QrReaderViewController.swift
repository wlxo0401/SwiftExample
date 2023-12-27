//
//  ViewController.swift
//  QrCodeSnapKit
//
//  Created by 김지태 on 12/27/23.
//

import UIKit
import SnapKit

class QrReaderViewController: UIViewController {
    // 카메라 화면
    var readerView: ReaderView!
    
    // 읽기 수행 버튼
    lazy var readButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        
        button.addAction(UIAction { _ in
            self.scanButtonAction()
        }, for: .touchUpInside)
        return button
    }()
    
    // 닫기 버튼
    lazy var closeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        
        button.addAction(UIAction { _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 기본 배경색
        self.view.backgroundColor = .white
        
        // UI
        self.setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }

    // UI 셋팅
    private func setUI() {
        
        // QR 리더 화면
        self.readerView = {
            let view: ReaderView = ReaderView()
            // 실행하기 전 색상
            view.backgroundColor = .blue
            view.delegate = self
            return view
        }()
        
        // QR 리더 화면 등록
        self.view.addSubview(self.readerView)
        
        // QR 리더 버튼
        self.view.addSubview(self.readButton)
        
        // 닫기 버튼
        self.view.addSubview(self.closeButton)
        
        // 제약 조건
        self.setUpConstraints()
    }
    
    // 제약 조건
    private func setUpConstraints() {
        // QR 리더 화면 제약조건
        self.readerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(300)
        }
        
        // QR 리더 버튼
        self.readButton.snp.makeConstraints {
            $0.top.equalTo(self.readerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(64)
        }
        
        // 닫기 버튼
        self.closeButton.snp.makeConstraints {
            $0.top.equalTo(self.readButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(64)
        }
    }

    private func scanButtonAction() {
        if self.readerView.isRunning {
            DispatchQueue.main.async {
                self.readerView.stop(isButtonTap: true)
            }
            
        } else {
            DispatchQueue.global().async {
                self.readerView.start()
            }
        }

        self.readButton.isSelected = self.readerView.isRunning
    }
}

extension QrReaderViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {

        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }

            title = "알림"
            message = "인식성공\n\(code)"
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                self.readButton.isSelected = readerView.isRunning
            } else {
                self.readButton.isSelected = readerView.isRunning
                return
            }
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
