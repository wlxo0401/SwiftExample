//
//  SecondViewController.swift
//  CameraPermission
//
//  Created by 김지태 on 2023/01/17.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var scanView: CodeScanView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.scanView.delegate = self
        
        
        if self.scanView.isRunning {
            self.scanView.stop()
        } else {
            self.scanView.start()
        }
        
        
    }
}
extension SecondViewController: CodeReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        print("status : ", status)
    }
}
