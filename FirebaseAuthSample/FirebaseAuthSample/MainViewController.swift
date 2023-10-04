//
//  MainViewController.swift
//  FirebaseAuthSample
//
//  Created by KimJitae on 2023/10/04.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let email = Auth.auth().currentUser?.email ?? "비회원"
        
        
        self.tempLabel.text = "\(email) 환영"
        
        // 이메일/비밀번호 조합으로 가입한 사용자
        let isEmailSignIn: Bool = Auth.auth().currentUser?.providerData[0].providerID == "password"
        // 비밀번호 변경 여부
        self.resetPasswordButton.isEnabled = isEmailSignIn
    }
    
    // MARK: - 로그아웃
    @IBAction func logOutButtonAction(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // 비밀번호 초기화
    @IBAction func resetPasswordButtonAction(_ sender: Any) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            // ...
          }
    }
}
