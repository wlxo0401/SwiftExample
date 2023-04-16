//
//  ViewController.swift
//  Calendar
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    @IBOutlet weak var fsCalendar: FSCalendar!
    
    private var currentPage: Date?
    
    private lazy var today: Date = {
        return Date()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.fsCalendar.dataSource = self
        self.fsCalendar.delegate = self
        // 1번째 방법 (추천)
        self.fsCalendar.locale = Locale(identifier: "ko_KR")
        // 상단 가운데 현재 월 포맷
        self.fsCalendar.appearance.headerDateFormat = "YYYY년 M월"
        // 상단 좌/우에 표시되던 전/후 월 투명도
        self.fsCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
        // 요일 글씨 색
        self.fsCalendar.appearance.weekdayTextColor = .black
        // 선택된 요일에 색
        self.fsCalendar.appearance.selectionColor = UIColor.blue
        
        self.fsCalendar.s = .
    }

    @IBAction func leftButtonAction(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    @IBAction func rightButtonAction(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
    //MARK: -사용자 정의 함수
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.fsCalendar.setCurrentPage(self.currentPage!, animated: true)
    }
}

extension ViewController: FSCalendarDataSource {
    
}

extension ViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("선택됨")
    }
}
