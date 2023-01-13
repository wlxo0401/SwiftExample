//
//  PieChartViewController.swift
//  ChartsLibTest
//
//  Created by 김지태 on 2022/11/15.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {

    
    @IBOutlet weak var myPieChart: PieChartView!
    
    var dayData: [String] = ["11월02일", "11월03일", "11월04일", "11월05일", "11월06일", "11월07일", "11월08일", "11월09일", "11월10일"]
    var priceData: [Double]! = [100, 345, 20, 120, 90, 300, 450, 220, 120]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let value = 10.0
        print(sqrt(value))
        
        
        
        // 기본 출력 텍스트
        self.myPieChart.noDataText = "출력 데이터가 없습니다."
        // 기본 출력 텍스트 폰트
        self.myPieChart.noDataFont = .systemFont(ofSize: 20)
        // 기본 출력 텍스트 색상
        self.myPieChart.noDataTextColor = .lightGray
        // Chart 뒷 배경 색상
        self.myPieChart.backgroundColor = .white
        
        
        self.setPieData(pieChartView: self.myPieChart, pieChartDataEntries: self.entryData(values: self.priceData))
        
    }
    
    // 데이터 적용하기
    func setPieData(pieChartView: PieChartView, pieChartDataEntries: [ChartDataEntry]) {
        // Entry들을 이용해 Data Set 만들기
        let pieChartdataSet = PieChartDataSet(entries: pieChartDataEntries, label: "매출")
        
        pieChartdataSet.drawValuesEnabled = false
        
        // DataSet을 차트 데이터로 넣기
        let pieChartData = PieChartData(dataSet: pieChartdataSet)
        // 데이터 출력
        pieChartView.data = pieChartData
    }

    // entry 만들기
    func entryData(values: [Double]) -> [ChartDataEntry] {
        // entry 담을 array
        var pieDataEntries: [ChartDataEntry] = []
        // 담기
        for i in 0 ..< values.count {
            let pieDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            pieDataEntries.append(pieDataEntry)
        }
        // 반환
        return pieDataEntries
    }

}



