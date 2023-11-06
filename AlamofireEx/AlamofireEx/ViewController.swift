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
        
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json"]
        
        // Body 데이터
        let parameters: Parameters = ["userId": "swift",
                                      "name": "kimjitae",
                                      "amount": 1000,
                                      "age": 27]
        
        // 쿼리 데이터
        let queryParam: Parameters = ["game": "KartRider"]
        
        // Request 생성
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        // Method 설정
        request.httpMethod = HTTPMethod.post.rawValue
        // 헤더
        request.headers = headers
        
        // 파라메터 Json String 변환
        if let location = self.dictionaryToJsonString(dictionary: parameters) {
            // here body is already serialized to Json
            request.httpBody = Data(location.utf8)
        }
        
        do {
            // 쿼리 데이터 추가
            request = try URLEncoding(destination: .queryString).encode(request, with: queryParam)
        } catch {
            print("Error creating request: \(error)")
        }
        
        AF.request(request)
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
    
    func dictionaryToJsonString(dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to JSON string: \(error)")
        }
        return nil
    }
}





//let headers: HTTPHeaders = ["Content-Type": "application/json",
//                            "Accept": "application/json"]
