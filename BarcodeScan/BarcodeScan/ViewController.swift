//
//  ViewController.swift
//  BarcodeScan
//
//  Created by 김지태 on 2023/01/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var readerView: CodeReaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.readerView.delegate = self
        
        if self.readerView.isRunning {
            self.readerView.stop()
        } else {
            self.readerView.start()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }

}

extension ViewController: CodeReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        print("status : ", status)
    }
}
