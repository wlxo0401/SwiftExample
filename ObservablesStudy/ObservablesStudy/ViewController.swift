//
//  ViewController.swift
//  ObservablesStudy
//
//  Created by 김지태 on 2023/02/13.
//

//https://velog.io/@kipsong/iOSDesignPattern-MVVM-%EA%B3%BC-DataBinding%EC%97%90-%EB%8C%80%ED%95%9C-%EA%B0%84%EB%9E%B5%ED%95%9C-%EC%86%8C%EA%B0%9C
import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ObservableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupData()
        setupBinding()
    }

    
    // MARK: - Helpers
    private func setupData() {
        viewModel.fetchData()
    }
    
    
    
    /* 여기서 바인딩하고 있습니다 */
    private func setupBinding() {
          /* storage의 값이 변경되면 reloadData를 실행합니다 */
        viewModel.storage.bind { [weak self] _ in
            guard let self = self else { return }
//                self.tableView.reloadData()
        }

        /* Error Handling */
        let message = "에러 발생"
        viewModel.errorMessage = Observable(message)
        
        viewModel.error.bind { isSuccess in
            if isSuccess {
                print("DEBUG: success")
            } else {
                print("DEBUG: \(self.viewModel.errorMessage)")
            }
        }
    }
}

class Repository {
    /* GET 메소드를 통한 API 통신(가정) */
    func getData(onCompleted: @escaping ([Stock]) -> Void) {
          /* 만약 통신을 한다면 통신을 모두 하고 난 이후 */
          /* 이스케이핑 클로저를 통해 값을 전달한다. */
        onCompleted(allStocks)
    }
}


let exampleStock1 = Stock(name: "삼성전자", price: 100000)
let exampleStock2 = Stock(name: "펄어비스", price: 130000)
let exampleStock3 = Stock(name: "NC소프트", price: 700000)
let exampleStock4 = Stock(name: "삼성화재", price: 200000)
let exampleStock5 = Stock(name: "진에어", price: 16000)
let exampleStock6 = Stock(name: "대한항공", price: 27000)

let allStocks = [exampleStock1,
                 exampleStock2,
                 exampleStock3,
                 exampleStock4,
                 exampleStock5,
                 exampleStock6]

protocol ObservableVMProtocol {
    associatedtype T
    
    // 데이터를 가져옵니다.
    func fetchData()
    
    // 에러를 처리합니다.
    func setError(_ message: String)
    
    // 원본데이터
    var storage: Observable<[T]> { get set }
    
    // 에러 메세지
    var errorMessage: Observable<String?> { get set }
    
    // 에러
    var error: Observable<Bool> { get set }
}

struct Stock {
    var name: String
    var price: Int
}

class ObservableViewModel: ObservableVMProtocol {
    typealias T = Stock
    
    
    private let repository = Repository()
    
    func fetchData() {
        //
        repository.getData { response in
            let observable = Observable(response)
            self.storage = observable
        }

    }
    
    func setError(_ message: String) {
        //
    }
    
    var storage: Observable<[Stock]> = Observable([])
    
    var errorMessage: Observable<String?> = Observable(nil)
    
    var error: Observable<Bool> = Observable(false)
    
    
}

class Observable<T> {
    // 3) 호출되면, 2번에서 받은 값을 전달한다.
    private var listener: ((T) -> Void)?
    
    // 2) 값이 set되면, listener에 해당 값을 전달한다,
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // 1) 초기화함수를 통해서 값을 입력받고, 그 값을 "value"에 저장한다.
    init(_ value: T) {
        self.value = value
    }
    
    // 4) 다른 곳에서 bind라는 메소드를 호출하게 되면,
    // value에 저장했떤 값을 전달해주고,
    // 전달받은 "closure" 표현식을 listener에 할당한다.
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
