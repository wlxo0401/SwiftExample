//
//  ReadyViewController.swift
//  CoordinatorPattern
//
//  Created by 김지태 on 10/27/23.
//

import UIKit

class ReadyViewController: UIViewController {

    var didSendEventClosure: ((LoginViewController.Event) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        didSendEventClosure?(.login)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReadyViewController {
    enum Event {
        case login
    }
}
