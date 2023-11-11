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
    lazy var tempLabel: UILabel = UILabel()
    
    // 더 불러오기 버튼
    lazy var tempButton: UIButton = UIButton()
    // 로딩
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
        
        // 기본 화면 설정
        self.view.backgroundColor = .white
        self.view.addSubview(self.tempLabel)
        self.view.addSubview(self.tempButton)
        self.view.addSubview(self.activityIndicationView)
        
        // UILabel AutoLayout 적용
        self.tempLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tempButton.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicationView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tempButton.backgroundColor = UIColor.black
        self.tempButton.setTitleColor(.white, for: .normal)
        self.tempButton.setTitle("더 불러오기", for: .normal)
        self.tempButton.addAction(UIAction { _ in
            self.viewModel.getData()
        }, for: .touchUpInside)
        
        // 제약 조건
        NSLayoutConstraint.activate([
            self.tempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tempLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.tempLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0),
            self.tempLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40.0),
            self.tempLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            self.tempButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tempButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40.0),
            self.tempButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0),
            self.tempButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40.0),
            self.tempButton.heightAnchor.constraint(equalToConstant: 30.0),
            
            self.activityIndicationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0),
            self.activityIndicationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40.0),
            self.activityIndicationView.heightAnchor.constraint(equalToConstant: 30.0),
        ])
        
        // UILabel 초기 값 설정
        self.tempLabel.text = "데이터 개수 : "
        
        
        self.setUpBindings()
        
        // 데이터 불러오기
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.viewModel.getData()
        }
    }
    
    // 바인딩 설정(함수 명은 예제를 그대로 복사한 것임.)
    private func setUpBindings() {
        func bindViewModelToView() {
            
            self.viewModel.$count
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] text in
                    DispatchQueue.main.async {
                        self?.tempLabel.text = "데이터 개수 : \(text)"
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
    
    // 에러 처리 팝업
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func startLoading() {
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        activityIndicationView.isHidden = true
        activityIndicationView.stopAnimating()
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

final class ActivityIndicatorView: UIActivityIndicatorView {
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        color = .white
        backgroundColor = .darkGray
        layer.cornerRadius = 5.0
        hidesWhenStopped = true
    }
}
