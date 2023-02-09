//
//  ViewController.swift
//  SwiftyTesseractStudy
//
//  Created by 김지태 on 2023/02/09.
//

import UIKit
import SwiftyTesseract


class ViewController: UIViewController {
    
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let startTime = CFAbsoluteTimeGetCurrent()
        let tesseract = Tesseract(languages: [.korean, .english], engineMode: .lstmOnly)
        let image = UIImage(named: "NameCardTop")!
        let result = tesseract.performOCR(on: image)
        let endTime = CFAbsoluteTimeGetCurrent() - startTime
        let publisher = tesseract.performOCRPublisher(on: image)
        
        
        print(endTime)
        
        print("Hi :", result)
        print("publisher : ", publisher.description)
    }


}

