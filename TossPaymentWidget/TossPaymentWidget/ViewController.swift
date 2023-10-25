//
//  ViewController.swift
//  TossPaymentWidget
//
//  Created by 김지태 on 10/24/23.
//

import UIKit
import TossPayments

class ViewController: UIViewController {

    // UI가 담길 공간
    public lazy var scrollView = UIScrollView()
    public lazy var stackView = UIStackView()
    
    /*
     위젯 생성
     clientKey - 내 상점의 클라이언트 키 즉 운영하는 서비스에 발부된 키
     customerKey - 고객 ID, 직접 생성해야하며 유출되면 악의적으로 사용할 수 있어 UUID와 같은 충분히 무작위적인 고유 값을 추천
     brandpay - 브랜드 페이를 사용하기 위함, Access Token 발급에 사용되는 리다이렉트 URL
     */
    private lazy var widget: PaymentWidget = PaymentWidget(
        clientKey: "test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq",
        customerKey: "EPUx4U0_zvKaGMZkA7uF_"
    )
    
    // 브랜드 페이 옵션 적용
//    private lazy var widget: PaymentWidget = PaymentWidget(
//        clientKey: "test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq",
//        customerKey: "EPUx4U0_zvKaGMZkA7uF_",
//        options: PaymentWidget.Options(brandpay: PaymentWidget.BrandPay(redirectURL: "http://my-store.com/brandpay/callback-auth"))
//    )
    
    // 결제 버튼
    private lazy var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 스택 뷰와 스크롤 뷰 추가
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.keyboardDismissMode = .onDrag
        
        // 스택 뷰 레이아웃
        self.stackView.spacing = 24
        self.stackView.axis = .vertical
        
        // 스택 뷰, 스크롤 뷰 AutoLayout을 사용하기 위함
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
                
        // AutoLayout
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 24),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -24),
            self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -48),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
        
        // 버튼 추가 및 설정
        self.view.addSubview(self.button)
        self.button.backgroundColor = .systemBlue
        self.button.setTitle("결제하기", for: .normal)
        self.button.addTarget(self, action: #selector(self.requestPayment), for: .touchUpInside)

        // 결제 위젯을 랜더링하는 메서드
        let paymentMethods = self.widget.renderPaymentMethods(amount: PaymentMethodWidget.Amount(value: 10000))
        // 브랜드 페이 옵션 적용
//        let paymentMethods = self.widget.renderPaymentMethods(amount: PaymentMethodWidget.Amount(value: 10000),
//                                                              options: PaymentMethodWidget.Options(variantKey: "BRANDPAY"))
        
        // 이용약관을 랜더링하는 메서드
        let agreement = self.widget.renderAgreement()

        // 랜더링 결과들을 스택 뷰에 Add
        self.stackView.addArrangedSubview(paymentMethods)
        self.stackView.addArrangedSubview(agreement)
        self.stackView.addArrangedSubview(self.button)

        // 위젯 결과를 위한 Delegate
        self.widget.delegate = self
        self.widget.paymentMethodWidget?.widgetStatusDelegate = self
    }
    
    // 고객이 선택한 결제 수단의 결제창을 띄우는 메서드
    @objc func requestPayment() {
        self.widget.requestPayment(
            info: DefaultWidgetPaymentInfo(
            orderId: "2VAhXURbYbiKwX5ybfrLr",
            orderName: "토스 티셔츠 외 2건")
        )
    }
}



extension ViewController: TossPaymentsDelegate {
    // 결제가 성공한 경우
    public func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        print("결제 성공")
        print("paymentKey: \(success.paymentKey)")
        print("orderId: \(success.orderId)")
        print("amount: \(success.amount)")
    }

    // 결제가 실패한 경우
    public func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        print("결제 실패")
        print("errorCode: \(fail.errorCode)")
        print("errorMessage: \(fail.errorMessage)")
        print("orderId: \(fail.orderId)")
    }
}

extension ViewController: TossPaymentsWidgetStatusDelegate {
    // 결제위젯 렌더링이 완료되면 호출되는 메서드
    public func didReceivedLoad(_ name: String) {
        print("결제위젯 렌더링 완료 ")
    }
}
