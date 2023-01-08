//
//  ViewController.swift
//  RadioButton
//
//  Created by 김지태 on 2023/01/08.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var radioButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.radioButtons.forEach {
            $0.addTarget(self, action: #selector(self.radioButton(_ :)), for: .touchUpInside)
        }
    }

    @objc private func radioButton(_ sender: UIButton) {
        print("선택된 버튼 : ", sender.tag)
        // UIButton 반복
        self.radioButtons.forEach {
            // sender로 들어온 버튼과 tag를 비교
            if $0.tag == sender.tag {
                // 같은 tag이면 색이 찬 동그라미로 변경
                $0.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            } else {
                // 다른 tag이면 색이 없는 동그라미로 변경
                $0.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
    
}

