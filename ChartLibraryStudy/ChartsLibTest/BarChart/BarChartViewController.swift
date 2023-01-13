//
//  ViewController.swift
//  ChartsLibTest
//
//  Created by 김지태 on 2022/11/07.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var myBarChartView: BarChartView!
    
    var dayData: [String] = ["11월02일", "11월03일", "11월04일", "11월05일", "11월06일", "11월07일", "11월08일", "11월09일", "11월10일"]
    var priceData: [Double]! = [100, 345, 20, 120, 90, 300, 450, 220, 120]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 데이터가 없을 때 보일 글씨
        self.myBarChartView.noDataText = "출력 데이터가 없습니다."
        // 데이터가 없을 때 보일 글씨 폰트
        self.myBarChartView.noDataFont = .systemFont(ofSize: 20)
        // 데이터가 없을 때 보일 글씨 색상
        self.myBarChartView.noDataTextColor = .red
        // 데이터가 없을 때 보일 글씨 폰트 정렬
        self.myBarChartView.noDataTextAlignment = .left
        
        
        self.myBarChartView.backgroundColor = .white
        
        
        // 데이터 범례 form 모양
        self.myBarChartView.legend.form = .square
        
        // x축 Grid
        self.myBarChartView.xAxis.drawGridLinesEnabled = true
        // x축 라벨
        self.myBarChartView.xAxis.drawLabelsEnabled = true
        // x축 선
        self.myBarChartView.xAxis.drawAxisLineEnabled = true
        
        print("self.myBarChartView.isDrawBarShadowEnabled : ", self.myBarChartView.isDrawBarShadowEnabled)
        
        // 데이터 범례 삭제
        self.myBarChartView.legend.enabled = false
        
        self.myBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayData)
        self.myBarChartView.xAxis.setLabelCount(priceData.count, force: false)
        self.setBarData(barChartView: self.myBarChartView, barChartDataEntries: self.entryData(values: self.priceData))
    }


    func setBarData(barChartView: BarChartView, barChartDataEntries: [BarChartDataEntry]) {
        let barChartdataSet = BarChartDataSet(entries: barChartDataEntries, label: "매출")

        // 밸류 속성
        barChartdataSet.drawValuesEnabled = false
        
        // 선 두께
//        barChartdataSet.barBorderWidth = 5
        
        // 선 색
//        barChartdataSet.barBorderColor = .red
        
//        barChartdataSet.isDrawBarShadowEnabled = true
        
        let barChartData = BarChartData(dataSet: barChartdataSet)
        barChartView.data = barChartData
    }
    
    // entry 만들기
    func entryData(values: [Double]) -> [BarChartDataEntry] {
        var barDataEntries: [BarChartDataEntry] = []
        for i in 0 ..< values.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            barDataEntries.append(barDataEntry)
        }
        return barDataEntries
    }
}

