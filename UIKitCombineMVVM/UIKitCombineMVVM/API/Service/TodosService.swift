//
//  TodosService.swift
//  UIKitCombineMVVM
//
//  Created by 김지태 on 11/10/23.
//

import Foundation
import Alamofire
import Combine

protocol TodosServiceProtocol {
    func get() -> AnyPublisher<[TodosModel], Error>
}

class TodosService: TodosServiceProtocol {
    func get() -> AnyPublisher<[TodosModel], Error> {
        let url: String = "https://jsonplaceholder.typicode.com/todos"
        
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json"]
                                        
        
        return AF.request(url, method: .get, headers: headers)
                   .validate(statusCode: 200..<300)
                   .validate(contentType: ["application/json"])
                   .publishDecodable(type: [TodosModel].self)
                   .tryMap { response in
                       switch response.result {
                       case .success(let players):
                           print("통신 완료")
                           return players
                       case .failure(let error):
                           throw error
                       }
                   }
                   .receive(on: DispatchQueue.main)
                   .eraseToAnyPublisher()
    }
}
