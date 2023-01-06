//
//  ViewController.swift
//  AlertEx
//
//  Created by 김지태 on 2023/01/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func normalButtonAction(_ sender: Any) {
        self.normalAlertMessage(viewController: self, title: "나는 노말", message: "안녕하세요")
    }
    
    
    //MARK: - 단순 확인 메세지 Alert
    internal func normalAlertMessage(viewController: UIViewController, title: String, message: String) {
        // Alert 생성
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Alert Action 생성
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            
            print("안녕하세요.")
            
        }
        // Alert에 Action 등록
        alert.addAction(okAction)
        // Alert 출력
        viewController?.present(alert, animated: true, completion: nil)
    }
}



