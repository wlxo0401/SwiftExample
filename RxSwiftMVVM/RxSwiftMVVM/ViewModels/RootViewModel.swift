//
//  RootViewModel.swift
//  RxSwiftMVVM
//
//  Created by 김지태 on 2023/03/10.
//

import Foundation
import RxSwift


final class RootViewModel {
    let title = "KimJitae News"
    
    private let articleService: ArticleServiceProtocol
    
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
    
    
    
}
