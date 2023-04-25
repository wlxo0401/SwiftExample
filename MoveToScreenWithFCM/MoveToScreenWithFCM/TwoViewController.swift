//
//  TwoViewController.swift
//  MoveToScreenWithFCM
//
//  Created by 김지태 on 2023/04/19.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        
        guard let threeVc = self.storyboard?.instantiateViewController(withIdentifier: "FourViewController") as? FourViewController else { return }
        threeVc.modalPresentationStyle = .fullScreen
        self.present(threeVc, animated: true)
        
    }
    
}
