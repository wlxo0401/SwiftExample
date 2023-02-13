//
//  ViewController.swift
//  AlamofireLayerStudy
//
//  Created by 김지태 on 2023/02/13.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case serverError(Error)
}

protocol NetworkProtocol {
  func request<T: Decodable>(
    _ endpoint: String,
    method: HTTPMethod,
    parameters: [String: Any]?,
    headers: HTTPHeaders?,
    completion: @escaping (Result<T, NetworkError>) -> Void
  )
}

class Network: NetworkProtocol {
  func request<T: Decodable>(
    _ endpoint: String,
    method: HTTPMethod,
    parameters: [String: Any]?,
    headers: HTTPHeaders?,
    completion: @escaping (Result<T, NetworkError>) -> Void
  ) {
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidURL))
      return
    }
    
    AF.request(
      url,
      method: method,
      parameters: parameters,
      encoding: JSONEncoding.default,
      headers: headers
    )
    .validate()
    .responseDecodable(of: T.self) { response in
      switch response.result {
      case .success(let value):
        completion(.success(value))
      case .failure(let error):
        completion(.failure(.serverError(error)))
      }
    }
  }
}
