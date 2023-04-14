//
//  ViewController.swift
//  TTS
//
//  Created by 김지태 on 2023/04/11.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    let volumeView = MPVolumeView()
    var systemVolume: Float = 0.0

    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 볼륨 슬라이더를 찾아서 볼륨 값을 가져옴
//        self.slider.maximumValue =
        
        
        self.ratio = 1 / AVAudioSession.sharedInstance().outputVolume
        
        // 시스템 볼륨 변화
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(systemVolumeDidChange),
                                                   name: Notification.Name("SystemVolumeDidChange"),
                                                   object: nil)
        
    }
    
    var ratio: Float = 0.0

    @objc func systemVolumeDidChange(notification: NSNotification) {
       
        
        
        if let volume = notification.userInfo?["Volume"] as? Float {
            // 볼륨 슬라이더를 찾아서 볼륨 값을 가져옴
            DispatchQueue.main.async {
                // 비율
                self.ratio = 1 / volume
                
                print("New Volume = \(notification.userInfo?["Volume"] as? Float)\n비율 : \(self.ratio)")
            }
        }
    }
    
    
    
    @IBAction func playButton(_ sender: Any) {
        
        print("TTS")
        
        TTSManager.shared.play("안녕하세요 안녕하세요")
        
    }
    
    
    
    @IBAction func slider(_ sender: UISlider) {
        print("sender : \(sender.value)")
        
        print("계산된 볼륨 : \(sender.value / self.ratio)")
        TTSManager.shared.volume = sender.value / self.ratio
    }
}


import AVFoundation

class TTSManager {
    
    static let shared = TTSManager()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    var volume: Float = 1.0
    
    internal func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        utterance.volume = self.volume
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
