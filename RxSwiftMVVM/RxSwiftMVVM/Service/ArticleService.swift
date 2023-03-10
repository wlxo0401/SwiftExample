//
//  ArticleService.swift
//  RxSwiftMVVM
//
//  Created by 김지태 on 2023/03/10.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
} 


class ArticleService: ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            
            self.fetchNews() { (error, articles) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    
    
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-02-10&sortBy=publishedAt&apiKey=7784dbd4ef114f78a4ce31b0cbb87bf7"
        
        guard let url = URL(string: urlString) else {
            return completion(NSError(domain: "wlxo0401", code: 404), nil)
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    return completion(error, nil)
                }
                
                if let articles = response.value?.articles {
                    return completion(nil, articles)
                }
            }
        
        
        
    }
}
