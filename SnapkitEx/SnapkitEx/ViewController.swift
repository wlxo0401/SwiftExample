//
//  ViewController.swift
//  SnapkitEx
//
//  Created by 김지태 on 11/20/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // 파랑색 View
    lazy var myView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    // 빨간색 View
    lazy var secondView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ViewController 배경색
        self.view.backgroundColor = .white
        
        // UI
        self.setUI()
    }
    
    // UI
    private func setUI() {
        // 슈퍼 View에 파랑색 View 추가
        self.view.addSubview(self.myView)
        self.view.addSubview(self.secondView)
        
        // SnapKit 적용
        self.myView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // SnapKit 적용
        self.secondView.snp.makeConstraints { make in
            make.top.equalTo(self.myView.snp.bottom).offset(-50)
            make.leading.equalToSuperview().offset(-50)
            make.trailing.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(50)
        }
    }
}



//// SnapKit 적용
//self.myView.snp.makeConstraints { make in
//    make.top.equalTo(self.view.snp.top)
//    make.leading.equalTo(self.view.snp.leading)
//    make.trailing.equalTo(self.view.snp.trailing)
//    make.height.equalTo(200)
//}
//
//// SnapKit 적용
//self.secondView.snp.makeConstraints { make in
//    make.top.equalTo(self.myView.snp.bottom)
//    make.leading.equalTo(self.view.snp.leading)
//    make.trailing.equalTo(self.view.snp.trailing)
//    make.bottom.equalTo(self.view.snp.bottom)
//}


//
//// UITableView
//lazy var tableView: UITableView = {
//    let tableView: UITableView = UITableView()
//    tableView.backgroundColor = .red
//    return tableView
//}()
//
//
//// UI
//private func setUI() {
//    // 슈퍼 View에 TableView 추가
//    self.view.addSubview(self.tableView)
//    
//    // SnapKit 적용
//    self.tableView.snp.makeConstraints {
//        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//        $0.leading.equalToSuperview()
//        $0.trailing.equalToSuperview()
//        $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//    }
//}
