//
//  ViewController.swift
//  TTS
//
//  Created by 김지태 on 2023/04/11.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    var ratio: Float = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func playButton(_ sender: Any) {
        
        print("TTS")
        
        TTSManager.shared.play("안녕하세요 안녕하세요")
        
    }
    
    
    
    @IBAction func slider(_ sender: UISlider) {
        TTSManager.shared.volume = sender.value
    }
}

class TTSManager {
    
    static let shared = TTSManager()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    var volume: Float = 1.0
    
    internal func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        utterance.volume = 1
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
