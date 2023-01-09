//
//  LineChartViewController.swift
//  ChartsLibTest
//
//  Created by 김지태 on 2022/11/10.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {

    @IBOutlet weak var myLineChart: LineChartView!

    var dayData: [String] = ["11월02일", "11월03일", "11월04일", "11월05일", "11월06일", "11월07일", "11월08일", "11월09일", "11월10일"]
    var priceData: [Double]! = [100, 345, 20, 120, 90, 300, 450, 220, 120]


    override func viewDidLoad() {
        super.viewDidLoad()

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
        self.myLineChart.xAxis.setLabelCount(priceData.count, force: false)

        
        
        self.setLineData(lineChartView: self.myLineChart, lineChartDataEntries: self.entryData(values: self.priceData))
    }


    // 데이터 적용하기
    func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry]) {
        // Entry들을 이용해 Data Set 만들기
        
        let lineChartdataSet = LineChartDataSet(entries: lineChartDataEntries, label: "매출")
        
        // 데이터셋에 색상 지정
        lineChartdataSet.colors = [.red, .blue]
        
        // DataSet을 차트 데이터로 넣기
        let lineChartData = LineChartData(dataSet: lineChartdataSet)
        
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
