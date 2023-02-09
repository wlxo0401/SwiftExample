//
//  ViewController.swift
//  SwiftyTesseractStudy
//
//  Created by 김지태 on 2023/02/09.
//

import UIKit


import SwiftyTesseract


class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. lstmOnly, default, tesseractLstmCombined, tesseractOnly
        // 일반 lstmOnly, default, tesseractLstmCombined, tesseractOnly
        // best lstmOnly, default
        let startTime = CFAbsoluteTimeGetCurrent()
        // 동작 수행 코드
        
        let tesseract = Tesseract(languages: [.korean, .english], engineMode: .default)
        let image = UIImage(named: "NameCardTop")!
        let result = tesseract.performOCR(on: image)
        let processTime = CFAbsoluteTimeGetCurrent() - startTime
        print("수행 시간 :", processTime)

        print("결과 :", result)
        
        
//         1. traineddata 3.04.00
//         시간 : 약 1.1초
//         결과 : 실장 강엔젤\n1. 02426-391 3\nPR5 혼 r. oz—ooo-oooo\nngel M. m o-oooo—oooo\nE. niacom2014@naver.com\n엔첼시 앤첼구 앤출르 1004\'\n엔췌티워 1004충\n
//
//         2. traineddata 4.00
//         시간 : 약 0.96초
//         결과 : 실 장 강 엔 젤\nT.02—326—3913\nPRé o F. 02—000—0000\n０9 이 M. 010—0000—0000\nE. niacom2014@naver.com\n인 젤 시 엔 젤 구 연 젤 로 １００4,\n연 젤 타 워 １００4 층\n
//
//         3-1. traineddata 4.0.0(chi_tra 데이터 없이)
//         시간 : 약 0.78초
//         결과 : 실 장 강 엔 젤\nㅠ 02-326-3913\nPRé > F. 02-000-0000\nngel M. 010-0000-0000\nE. niacom2014@naver.com\n엔 젤 시 엔 젤 구 엔 젤 로 1004,\n엔 젤 타 워 1004 층\n
//
//         3-2. traineddata 4.0.0(chi_tra 데이터 있이)
//         시간 : 약 1.3초
//         결과 : 실 장 강 엔 젤\nㅠ 02-326-3913\nPRé > F. 02-000-0000\nngel M. 010-0000-0000\nE. niacom2014@naver.com\n엔 젤 시 엔 젤 구 엔 젤 로 1004,\n엔 젤 타 워 1004 층\n
//
//
//         4-1. traineddata 4.1.0(chi_tra 데이터 없이)
//         시간 : 약 0.78초
//         결과 : 실 장 강 엔 젤\nㅠ 02-326-3913\nPRé > F. 02-000-0000\nngel M. 010-0000-0000\nE. niacom2014@naver.com\n엔 젤 시 엔 젤 구 엔 젤 로 1004,\n엔 젤 타 워 1004 층\n
//
//         4-2. traineddata 4.1.0(chi_tra 데이터 있이)
//         시간 : 약 1.2초
//         결과 : 실 장 강 엔 젤\nㅠ 02-326-3913\nPRé > F. 02-000-0000\nngel M. 010-0000-0000\nE. niacom2014@naver.com\n엔 젤 시 엔 젤 구 엔 젤 로 1004,\n엔 젤 타 워 1004 층\n
//
//         5. traineddata_best 4.0.0
//         시간 : 약 1.9초
//         결과 : 실장 강엔 젤\nT.02-326-3913\nPR: >               F. 02-000-0000\nngel           M. 010-0000-0000\nE. niacom2014@naver.com\n엔젤시 엔젤구 엔젤로 1004,\n엔젤타워 1004충\n
//
//         6. traineddata_best 4.1.0
//         시간 : 약 1.9초
//         결과 : 실장 강엔 젤\nT.02-326-3913\nPR: >               F. 02-000-0000\nngel           M. 010-0000-0000\nE. niacom2014@naver.com\n엔젤시 엔젤구 엔젤로 1004,\n엔젤타워 1004충\n
        
    }


}

