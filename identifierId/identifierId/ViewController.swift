//
//  ViewController.swift
//  identifierId
//
//  Created by 김지태 on 2023/03/20.
//

import UIKit
import DeviceCheck

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        
        print("UUID : \(uuid)")
        
        print(UIDevice.current.identifierForVendor?.uuidString)
        print(UIDevice.current.identifierForVendor?.uuidString)
        
        
        print(UUID().uuidString)
        print(UUID().uuidString)
        // EC5FCB00-BA20-4337-A30C-BDF738B4EA73
        sendEphemeralToken()
    }
    func sendEphemeralToken() {
            //check if DCDevice is available (iOS 11)

            //get the **ephemeral** token
            DCDevice.current.generateToken {
            (data, error) in
            guard let data = data else {
                return
            }

            //send **ephemeral** token to server to
            let token = data.base64EncodedString()
                
                
                print(token)
                
            //Alamofire.request("https://myServer/deviceToken" ...
        }
    }

}

