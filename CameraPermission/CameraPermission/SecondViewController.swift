//
//  SecondViewController.swift
//  CameraPermission
//
//  Created by 김지태 on 2023/01/17.
//

import UIKit
import PhotosUI


class SecondViewController: UIViewController {

    @IBOutlet weak var scanView: CodeScanView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.CameraPermission()
        
        
        self.scanView.delegate = self
        
        
        if self.scanView.isRunning {
            self.scanView.stop()
        } else {
            self.scanView.start()
        }
        
        
    }
    
    private func CameraPermission() {
       AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
           if granted {
               print("Camera: 권한 허용")
           } else {
               print("Camera: 권한 거부")
//               self.showAlertGoToSetting()
           }
       })
    }
}
extension SecondViewController: CodeReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        print("status : ", status)
    }
}
