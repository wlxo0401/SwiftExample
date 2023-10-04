//
//  LoginViewController.swift
//  FirebaseAuthSample
//
//  Created by KimJitae on 2023/10/04.
//

import UIKit
import Firebase
import GoogleSignIn

import AuthenticationServices
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    @IBOutlet weak var appleButton: ASAuthorizationAppleIDButton!
    
    
    private var currentNonce: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        self.appleButton.addTarget(self, action: #selector(self.startSignInWithAppleFlow), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailButtonAction(_ sender: Any) {
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
        // 구글 로그인
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self,
                  let result = signInResult,
                  let idToken = result.user.idToken?.tokenString else { return }
            // 에러 여부 확인
            if let error = error {
                // 에러 처리
                let errorCode = (error as NSError).code
                switch errorCode {
                case 17007:
                    // 이미 존재하는 계정입니다. -> 로그인 진행
                    print(error.localizedDescription)
                default:
                    print(error.localizedDescription)
                }
            } else {
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: result.user.accessToken.tokenString)
                
                
                Auth.auth().signIn(with: credential) { result, error in
                    // 에러 여부 확인
                    if let error = error {
                        // 에러 처리
                        let errorCode = (error as NSError).code
                        switch errorCode {
                        case 17007:
                            // 이미 존재하는 계정입니다. -> 로그인 진행
                            print(error.localizedDescription)
                        default:
                            print(error.localizedDescription)
                        }
                    } else {
                        self.goMain()
                    }
                }
            }
        }
    }
    
    
    
    @objc func startSignInWithAppleFlow() {
        let nonce = AppleLogin.randomNonceString()
        self.currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        // request 요청을 했을 때 none가 포함되어서 릴레이 공격을 방지
        // 추후 파베에서도 무결성 확인을 할 수 있게끔 함
        request.requestedScopes = [.fullName, .email]
        request.nonce = AppleLogin.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 메인화면 진입
    private func goMain() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
}


extension LoginViewController: ASAuthorizationControllerDelegate {
    
    // controller로 인증 정보 값을 받게 되면은, idToken 값을 받음
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // nonce : 암호화된 임의의 난수, 단 한번만 사용 가능
            // 동일한 요청을 짧은 시간에 여러번 보내는 릴레이 공격 방지
            // 정보 탈취 없이 안전하게 인증 정보 전달을 위한 안전장치

            guard let nonce = self.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                // 안전하게 인증 정보를 전달하기 위해 nonce 사용

            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            // token들로 credential을 구성해서 auth signin 구성 (google과 동일)
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                self.goMain()
            }
        }
    }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


import CryptoKit

struct AppleLogin {
    static var staticProperty: Int = 0
    
    static func staticMethod() {
        print("This is a static method.")
    }
    
    
    
    static internal func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }

    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    static internal func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}
