//
//  EnterEmailViewController.swift
//  FirebaseAuthSample
//
//  Created by KimJitae on 2023/10/04.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    
    // 이메일 TextField
    @IBOutlet weak var emailTextField: UITextField!
    // 비밀번호 TextField
    @IBOutlet weak var passwordTextField: UITextField!
    // 다음 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 다음 버튼 비활성화
        self.nextButton.isEnabled = false
        
        // TextField Delegate 등록
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // 화면 들어오자마자 Email 포커싱
        self.emailTextField.becomeFirstResponder()
    }
    
    // MARK: - 다음 버튼 동작
    @IBAction func nextButtonAction(_ sender: Any) {
        // 입력된 이메일과 비밀번호 받아오기
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        // Firebase에 회원가입 요청
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            // 에러 여부 확인
            if let error = error {
                // 에러 처리
                let errorCode = (error as NSError).code
                switch errorCode {
                case 17007:
                    // 이미 존재하는 계정입니다. -> 로그인 진행
                    self.login(email: email, pw: password)
                default:
                    print(error.localizedDescription)
                }
            } else {
                // 회원가입 성공
                self.goMain()
            }
        }
    }
    
    // 이미 회원가입된 경우 로그인 동작
    private func login(email: String, pw: String) {
        // 로그인 요청
        Auth.auth().signIn(withEmail: email, password: pw) {[weak self] _, error in
            guard let self = self else { return }
            
            // 에러 여부 확인
            if let error = error {
                // 로그인 실패
                print(error.localizedDescription)
            } else {
                // 로그인 성공
                self.goMain()
            }
        }
    }
    
    // 메인화면 진입
    private func goMain() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Return 누르면 수정 기능 종료
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 다음 버튼 활성화 여부
        let isEmailEmpty = self.emailTextField.text != ""
        let isPwEmpty = self.passwordTextField.text != ""
        
        self.nextButton.isEnabled = isEmailEmpty && isPwEmpty
    }
}
