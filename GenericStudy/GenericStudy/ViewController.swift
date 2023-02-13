//
//  ViewController.swift
//  GenericStudy
//
//  Created by 김지태 on 2023/02/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        var a = "안녕"
        var b = "ㅇ하세요"
        
        self.swapTwoValues(&a, &b)
        
        print(a)
        print(b)
    }

    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let tempA = a
        a = b
        b = tempA
        print("a : \(a), b : \(b)")
    }
    
//    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
//        let tempA = a
//        a = b
//        b = tempA
//    }

}

