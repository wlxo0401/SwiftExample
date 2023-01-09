//
//  MultiLineChartViewController.swift
//  ChartsLibTest
//
//  Created by 김지태 on 2023/01/09.
//

import UIKit
import Charts

class MultiLineChartViewController: UIViewController {

    @IBOutlet weak var myLineChart: LineChartView!
    
    var dayData: [String] = ["11월02일", "11월03일", "11월04일", "11월05일", "11월06일", "11월07일", "11월08일", "11월09일", "11월10일"]
    
    var priceDataOne: [Double]! = [100, 345, 20, 120, 90, 300, 450, 220, 120]
    var priceDataTwo: [Double]! = [50, 200, 200, 300, 150, 250, 200, 400, 200]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 기본 출력 텍스트
        self.myLineChart.noDataText = "출력 데이터가 없습니다."
        // 기본 출력 텍스트 폰트
        self.myLineChart.noDataFont = .systemFont(ofSize: 20)
        // 기본 출력 텍스트 색상
        self.myLineChart.noDataTextColor = .lightGray
        // Chart 뒷 배경 색상
        self.myLineChart.backgroundColor = .white
        // 값마다 구분하고 싶은 valueFormatter 예) 날짜, 이름
        self.myLineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayData)
        // 값마다 구분하고 싶은 valueFormatter를 개수만큼 출력
        self.myLineChart.xAxis.setLabelCount(dayData.count, force: false)

        // 추가하고 싶은 데이터
        let lineChartDataEntries: [[ChartDataEntry]] = [self.entryData(values: self.priceDataOne),
                                                        self.entryData(values: self.priceDataTwo)]
        
        // 라인 차트 그리기
        self.setLineData(lineChartView: self.myLineChart, lineChartDataEntries: lineChartDataEntries)
    }

    // 데이터 적용하기
    func setLineData(lineChartView: LineChartView, lineChartDataEntries: [[ChartDataEntry]]) {
        // Entry들을 이용해 Data Set 만들기
        var dataSets: [LineChartDataSet] = []
        
        // 데이터 생성
        for entry in lineChartDataEntries {
            let lineChartdataSet = LineChartDataSet(entries: entry, label: "매출")
            dataSets.append(lineChartdataSet)
        }
        
        // DataSet을 차트 데이터로 넣기
        let lineChartData = LineChartData(dataSets: dataSets)
        
        // 데이터 출력
        lineChartView.data = lineChartData
    }

    // entry 만들기
    func entryData(values: [Double]) -> [ChartDataEntry] {
        // entry 담을 array
        var lineDataEntries: [ChartDataEntry] = []
        // 담기
        for i in 0 ..< values.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            lineDataEntries.append(lineDataEntry)
        }
        // 반환
        return lineDataEntries
    }
}
