//
//  ViewController.swift
//  UserDefatults
//
//  Created by 김지태 on 2023/01/06.
//

import UIKit

class ViewController: UIViewController {
    
    // userdefaults
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //MARK: - 저장하기
    @IBAction func saveButtonAction(_ sender: Any) {
        // String Type
        self.setString(string: "Hi")
        
        // Int Type
        self.setInt(int: 100)
        
        // Bool Type
        self.setBool(bool: true)
        
        // Array Type
        self.setArray(array: ["나는", "아이폰"])
    }
    
    //MARK: - 불러오기
    @IBAction func loadButtonAction(_ sender: Any) {
        // String Type
        print("String : ", self.getString())
        
        // Int Type
        print("Int : ", self.getInt())
        
        // Bool Type
        print("Bool : ", self.getBool())
        
        // Array Type
        print("Array : ", self.getArray())
    }
    
    //MARK: - 초기화
    @IBAction func resetButtonAction(_ sender: Any) {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}

extension ViewController {
    
    //MARK: - String
    // 저장하기
    func setString(string: String) {
        defaults.set(string, forKey: "string")
    }
    // 불러오기
    func getString() -> String {
        if let string = defaults.object(forKey: "string") {
            return string as! String
        }
        return ""
    }
    
    //MARK: - Int
    // 저장하기
    func setInt(int: Int) {
        defaults.set(int, forKey: "int")
    }
    // 불러오기
    func getInt() -> Int {
        if let int = defaults.object(forKey: "int") {
            return int as! Int
        }
        return 0
    }
    
    //MARK: - Bool
    // 저장하기
    func setBool(bool: Bool) {
        defaults.set(bool, forKey: "bool")
    }
    // 불러오기
    func getBool() -> Bool {
        if let bool = defaults.object(forKey: "bool") {
            return bool as! Bool
        }
        return false
    }
    
    //MARK: - Array
    // 저장하기
    func setArray(array: [String]) {
        defaults.set(array, forKey: "array")
    }
    // 불러오기
    func getArray() -> Array<String> {
        if let array = defaults.array(forKey: "array") {
            return array as! Array
        }
        return []
    }
}

