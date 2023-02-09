//
//  ViewController.swift
//  TesseractOCRiOSStudy
//
//  Created by 김지태 on 2023/02/09.
//

import UIKit

import TesseractOCR

class ViewController: UIViewController {

    // https://github.com/gali8/Tesseract-OCR-iOS/wiki/Using-Tesseract-OCR-iOS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startTime = CFAbsoluteTimeGetCurrent()
        if let tesseract = G8Tesseract(language: "kor+eng") {
            // 2
            tesseract.engineMode = .tesseractOnly
            // 3
            tesseract.pageSegmentationMode = .auto
            // 4
            tesseract.image = UIImage(named: "NameCardTop")!
//            tesseract.image = UIImage(named: "NameCardLeft")!
            // 5
            tesseract.recognize()
            // 6
            let endTime = CFAbsoluteTimeGetCurrent() - startTime
            print(endTime)
            print(tesseract.recognizedText)
        }

        
        // Do any additional setup after loading the view.
    }


}

