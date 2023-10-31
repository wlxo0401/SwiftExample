//
//  BillingViewController.swift
//  TossPaymentWidget
//
//  Created by 김지태 on 10/31/23.
//

import UIKit
import WebKit

class BillingViewController: UIViewController {

    @IBOutlet weak var tossBillingWKView: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 토스 예제 클라이언트 키(안될 수 있음)
        let clientKey: String = "test_ck_D5GePWvyJnrK0W0k6q338gLzN97Eoq"
        // 토스 예제 고객 키(안될 수 있음)
        let customerKey: String = "Vj_mNuQtPv_f923hNcDMb4L"
        
        // 성공/실패시 이동할 URL
        let cardSuccessUrl: String = "http://localhost:8080/card/success"
        let cardFailUrl: String =  "http://localhost:8080/card/fail"
        
        let tossWeb: String = """
                            <head>
                              <title>결제하기</title>
                              <meta charset="utf-8" />
                              <!-- 토스페이먼츠 결제창 SDK 추가 -->
                              <script src="https://js.tosspayments.com/v1/payment"></script>
                            </head>
                            <body>
                              <script>
                                // ------ 클라이언트 키로 객체 초기화 ------
                                var clientKey = '\(clientKey)'
                                var tossPayments = TossPayments(clientKey)
                            
                                tossPayments.requestBillingAuth('CARD', { // 결제수단 파라미터 (자동결제는 카드만 지원합니다.)
                                  // 결제 정보 파라미터
                                  customerKey: '\(customerKey)', // 고객 ID로 상점에서 만들어야 합니다. 빌링키와 매핑됩니다. 자세한 파라미터 설명은 파라미터 설명을 참고하세요: https://docs.tosspayments.com/reference/js-sdk#결제-정보-5
                                  successUrl: "\(cardSuccessUrl)", // 카드 등록에 성공하면 이동하는 페이지(직접 만들어주세요)
                                  failUrl: "\(cardFailUrl)",       // 카드 등록에 실패하면 이동하는 페이지(직접 만들어주세요)
                                })
                                .catch(function (error) {
                                  if (error.code === 'USER_CANCEL') {
                                    // 결제 고객이 결제창을 닫았을 때 에러 처리
                                  }
                                })
                              </script>
                            </body>
                            """
        // 토스 웹킷 Delegate
        self.tossBillingWKView.navigationDelegate = self
        
        self.tossBillingWKView.loadHTMLString(tossWeb, baseURL: nil)
        
        
    }
}

extension BillingViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        let urlString = url.absoluteString
        print("결과. :\(urlString)")
        
        // Check if the URL contains "/success"
        if urlString.contains("/card/success") {
            // 성공인 경우
            
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            // Customer Key
            let customerKey = urlComponents?.queryItems?.first(where: { $0.name == "customerKey" })?.value
            // Auth Key
            let authKey = urlComponents?.queryItems?.first(where: { $0.name == "authKey" })?.value
            
            decisionHandler(.cancel)
        } else if urlString.contains("/card/fail") {
            // 실패한 경우
            
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            // Error Code
            let code = urlComponents?.queryItems?.first(where: { $0.name == "code" })?.value
            // Error Message
            let message = urlComponents?.queryItems?.first(where: { $0.name == "message" })?.value
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
