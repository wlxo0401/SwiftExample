//
//  ThreeViewController.swift
//  PageViewController
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit

class ThreeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad : 3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear : 3")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear : 3")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear : 3")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear : 3")
    }
}
