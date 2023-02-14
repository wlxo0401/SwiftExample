//
//  ViewController.swift
//  VisionOCRStudy
//
//  Created by 김지태 on 2023/02/10.
//

import UIKit

import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(VNRecognizeTextRequest().revision)
        print(VNRecognizeTextRequest().recognitionLanguages)
        
        let image = UIImage(named: "testDemo")

        if let cgImage = image?.cgImage {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)

            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    return
                }

                let recognizedStrings = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }

                DispatchQueue.main.async {
                    print(recognizedStrings)
                }
            }

            recognizeTextRequest.recognitionLevel = .fast

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try requestHandler.perform([recognizeTextRequest])
                } catch {
                    print(error)
                }
            }
        }
        
        
        self.visionChatGPT()
        
    }


}

extension ViewController {
    private func visionChatGPT() {
        let image = UIImage(named: "testDemo")
        let requestHandler = VNImageRequestHandler(cgImage: (image?.cgImage)!, options: [:])
        
        
        let textDetectionRequest = VNDetectTextRectanglesRequest(completionHandler: { (request, error) in
            // Code to handle the recognized text
//            print("textDetectionRequest :", textDetectionRequest)
            
        })
        try? requestHandler.perform([textDetectionRequest])

        guard let observations = textDetectionRequest.results as? [VNTextObservation] else { return }
        print("observations: ", observations)
        for region in observations {
            guard let boxes = region.characterBoxes else { continue }
            
            print("boxes :",boxes)
            for characterBox in boxes {
                // Code to extract the recognized text
            }
        }

    }
    
    
}
