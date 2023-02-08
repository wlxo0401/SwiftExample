//
//  ViewController.swift
//  SwiftyTesseractStudy
//
//  Created by 김지태 on 2023/02/08.
//

import UIKit
import SwiftyTesseract

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tesseract = Tesseract(languages: [.english, .korean])
        
//        let imageData = try Data(contentsOf: urlOfYourImage)
        
        let imageData = UIImage(named: "someImageWithText.jpg")!
        let result: Result<String, Tesseract.Error> = tesseract.performOCR(on: imageData)
        print(result)
    }


}

