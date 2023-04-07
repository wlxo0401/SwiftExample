//
//  ViewController.swift
//  SpmChartsLibrary
//
//  Created by 김지태 on 2023/03/22.
//

import UIKit
import Charts


class ViewController: UIViewController {

    @IBOutlet weak var myBarChartView: BarChartView!
    
    // 구분값
        var dayData: [String] = ["8월", "9월", "10월", "11월", "12월", "1월"]
          // 데이터
          var priceData: [Double]! = [75, 22, 45, 80, 50, 100]


    override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view.

        // 기본 문구
        self.myBarChartView.noDataText = "출력 데이터가 없습니다."
        // 기본 문구 폰트
        self.myBarChartView.noDataFont = .systemFont(ofSize: 20)
        // 기본 문구 색상
        self.myBarChartView.noDataTextColor = .lightGray
        // 차트 기본 뒷 배경색
        self.myBarChartView.backgroundColor = .white
        // 구분값 보이기
        self.myBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayData)
        
        
        // x축 Grid
        self.myBarChartView.xAxis.drawGridLinesEnabled = false
        
        // 왼쪽 벽 데이터 제거
        self.myBarChartView.leftAxis.enabled = false
        // 오른쪽 벽 데이터 제거
        self.myBarChartView.rightAxis.enabled = false
        
        // 범주 제거
        self.myBarChartView.legend.enabled = false
        
        // 그래프 왼쪽 벽 제거
        self.myBarChartView.leftAxis.drawAxisLineEnabled = false
        // 그래프 오른쪽 벽 제거
        self.myBarChartView.rightAxis.drawAxisLineEnabled = false
        // 정보 아래로 내리기
        self.myBarChartView.xAxis.labelPosition = .bottom
        
        // 구분값 모두 보이기
        self.myBarChartView.xAxis.setLabelCount(priceData.count, force: false)
        
        
        
        
        
        // 생성한 함수 사용해서 데이터 적용
        self.setBarData(barChartView: self.myBarChartView, barChartDataEntries: self.entryData(values: self.priceData))
    }

    // 데이터셋 만들고 차트에 적용하기
    func setBarData(barChartView: BarChartView, barChartDataEntries: [BarChartDataEntry]) {
        // 데이터 셋 만들기
        let barChartdataSet = BarChartDataSet(entries: barChartDataEntries, label: "매출")
        
        
        // 차트 데이터 만들기
        let barChartData = BarChartData(dataSet: barChartdataSet)
        // 데이터 차트에 적용
        barChartView.data = barChartData
    }

    // entry 만들기
    func entryData(values: [Double]) -> [BarChartDataEntry] {
        // 엔트리들 만들기
        var barDataEntries: [BarChartDataEntry] = []
        // 데이터 값 만큼 엔트리 생성
        for i in 0 ..< values.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            barDataEntries.append(barDataEntry)
        }
        // 엔트리들 반환
        return barDataEntries
    }
}
