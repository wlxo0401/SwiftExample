//
//  ViewController.swift
//  AlamofireEx
//
//  Created by 김지태 on 10/25/23.
//

import UIKit
import Alamofire

struct TestModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url: String = "https://jsonplaceholder.typicode.com/todos"
        
        AF.request(url,
                   method: .get)
                    .validate(statusCode: 200..<300)
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: [TestModel].self) { (response) in
                        switch response.result {
                        case .success(let result):
                            print("데이터 개수 : \(result.count)")
                        case .failure(let error):
                            print("통신 에러 \(error.localizedDescription)")
                        }
                    }
    }
}





//let headers: HTTPHeaders = ["Content-Type": "application/json",
//                            "Accept": "application/json"]
