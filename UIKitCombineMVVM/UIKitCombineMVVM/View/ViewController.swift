//
//  ViewController.swift
//  UIKitCombineMVVM
//
//  Created by 김지태 on 11/10/23.
//
import UIKit
import Combine

class ViewController: UIViewController {
    // API를 통해서 불러온 데이터 개수 표시 Label
    lazy var todoCountLabel: UILabel = UILabel()
    // 더 불러오기 버튼
    lazy var apiButton: UIButton = UIButton()
    // 로딩 UI
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    // ViewModel
    private let viewModel: ViewModel
    
    // Comine
    private var bindings = Set<AnyCancellable>()
    private var cancellables = Set<AnyCancellable>()
    
    // 의존성
    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UI 설정
        self.setUI()
        
        // Combine 설정
        self.setUpBindings()
    }
    
    // 바인딩 설정(함수 명은 예제를 그대로 복사한 것임.)
    private func setUpBindings() {
        func bindViewModelToView() {
            
            // Count가 변경되면
            self.viewModel.$count
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] text in
                    DispatchQueue.main.async {
                        self?.todoCountLabel.text = "데이터 개수 : \(text)"
                    }
                })
                .store(in: &bindings)
            
            // 통신 상태 Handler
            let stateValueHandler: (ViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    print("로딩 시작")
                    self?.startLoading()
                case .finishedLoading:
                    print("로딩 완료")
                    self?.finishLoading()
                case .error(let error):
                    print("로딩 완료")
                    // 에러 처리
                    self?.showError(error)
                }
            }
            
            // State를 구독
            self.viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewModelToView()
        
        if self.viewModel.count == 0 {
            self.viewModel.getData()
        }
    }
}

// MARK: UI
extension ViewController {
    private func setUI() {
        // 기본 화면 설정
        self.view.backgroundColor = .white
        
        // UI 추가
        self.view.addSubview(self.todoCountLabel)
        self.view.addSubview(self.apiButton)
        self.view.addSubview(self.activityIndicationView)
        
        // UILabel AutoLayout 사용
        self.todoCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.apiButton.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicationView.translatesAutoresizingMaskIntoConstraints = false
        
        // 더 불러오기 버튼
        self.apiButton.backgroundColor = UIColor.black
        self.apiButton.setTitleColor(.white, for: .normal)
        self.apiButton.setTitle("더 불러오기", for: .normal)
        self.apiButton.addAction(UIAction { _ in
            // 데이터 불러오기
            self.viewModel.getData()
        }, for: .touchUpInside)
        
        // 제약 조건
        NSLayoutConstraint.activate([
            // 데이터 개수 Label UI 설정
            self.todoCountLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.todoCountLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.todoCountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0),
            self.todoCountLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40.0),
            self.todoCountLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            // 더 불러오기 Button UI 설정
            self.apiButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.apiButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40.0),
            self.apiButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0),
            self.apiButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40.0),
            self.apiButton.heightAnchor.constraint(equalToConstant: 30.0),
            
            // 로딩 Indicator View UI 설정
            self.activityIndicationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.activityIndicationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.activityIndicationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.activityIndicationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // UILabel 초기 값 설정
        self.todoCountLabel.text = "데이터 개수 : "
    }
    
    // 에러 팝업
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // 로딩 보이기
    func startLoading() {
        self.activityIndicationView.isHidden = false
        self.activityIndicationView.startAnimating()
    }
    
    // 로딩 숨기기
    func finishLoading() {
        self.activityIndicationView.isHidden = true
        self.activityIndicationView.stopAnimating()
    }
}




// MARK: - 나중에 다시 확인하기 위한 코드.
//            viewModel.$count
//                .sink { [weak self] text in
//                    DispatchQueue.main.async {
//                        self?.tempLabel.text = text
//                    }
//                }
//                .store(in: &cancellables) // 누락된 부분
    
    
//            viewModel.dataFetchComplete
//                .sink(receiveCompletion: { [weak self] completion in
//                    guard let self = self else { return }
//                    switch completion {
//                    case .finished:
//                        break // 성공적으로 완료된 경우, 아무것도 처리하지 않음
//                    case .failure(let error):
//                        print("통신 에러 \(error.localizedDescription)")
//                        // 에러를 처리하거나 UI 업데이트 등을 수행
//                    }
//                }, receiveValue: { [weak self] in
//                    guard let self = self else { return }
//                    DispatchQueue.main.async {
//                        self.tempLabel.text = self.viewModel.count // 데이터 업데이트
//                    }
//                })
//                .store(in: &cancellables)

