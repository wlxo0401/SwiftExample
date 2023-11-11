//
//  ViewModel.swift
//  UIKitCombineMVVM
//
//  Created by 김지태 on 11/10/23.
//

import Foundation
import Combine

enum ViewModelError: Error, Equatable {
    case playersFetch
}

enum ViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(ViewModelError)
}

class ViewModel {
    // 개수
    @Published var count: Int = 0
    @Published private(set) var state: ViewModelState = .loading
    
    // let dataFetchComplete = PassthroughSubject<Void, Error>()
    
    private let todosService: TodosServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(todosService: TodosServiceProtocol = TodosService()) {
        self.todosService = todosService
    }
    
    func getData() {
        self.state = .loading
        fetchTodos()
    }
    
    func fetchTodos() {
        let searchTermCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.playersFetch)
            case .finished:
                self?.state = .finishedLoading
            }
        }
        
        let searchTermValueHandler: ([TodosModel]) -> Void = { [weak self] todos in
            guard let self = self else { return }
            self.count += todos.count
        }
        
        self.todosService.get()
            .sink(receiveCompletion: searchTermCompletionHandler,
                  receiveValue: searchTermValueHandler)
            .store(in: &bindings)
    }
}

