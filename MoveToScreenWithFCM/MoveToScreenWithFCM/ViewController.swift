//
//  ViewController.swift
//  MoveToScreenWithFCM
//
//  Created by 김지태 on 2023/04/19.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        if self.getCurrentResourceVersion() == "2" {
            guard let twoVc = self.storyboard?.instantiateViewController(withIdentifier: "TwoViewController") as? TwoViewController else { return }
            self.navigationController?.pushViewController(twoVc, animated: true)
            UserDefaults.standard.set("0", forKey: "currentResourceVersion")
        } else if self.getCurrentResourceVersion() == "3" {
            guard let threeVc = self.storyboard?.instantiateViewController(withIdentifier: "ThreeViewController") as? ThreeViewController else { return }
            self.navigationController?.pushViewController(threeVc, animated: true)
            UserDefaults.standard.set("0", forKey: "currentResourceVersion")
        } else if self.getCurrentResourceVersion() == "4" {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FourViewController") as? FourViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            UserDefaults.standard.set("0", forKey: "currentResourceVersion")
        }
        
        
    }

    @IBAction func contentButton(_ sender: Any) {
        
        self.label.text = self.getCurrentResourceVersion()
    }
    
    // 단말기에 설치된 리소스 버전 불러오기
    func getCurrentResourceVersion() -> String {
        if let currentResourceVersion = UserDefaults.standard.string(forKey: "currentResourceVersion") {
            return currentResourceVersion
        }
        return "내용 없음"
    }
    
    
    @IBAction func APuch(_ sender: Any) {
        
        guard let twoVc = self.storyboard?.instantiateViewController(withIdentifier: "TwoViewController") as? TwoViewController else { return }
        self.navigationController?.pushViewController(twoVc, animated: true)
        
        
    }
    
    @IBAction func Bpush(_ sender: Any) {
        
        
        guard let threeVc = self.storyboard?.instantiateViewController(withIdentifier: "ThreeViewController") as? ThreeViewController else { return }
        self.navigationController?.pushViewController(threeVc, animated: true)
        
    }
}

