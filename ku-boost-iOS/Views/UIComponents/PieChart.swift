//
//  PieChart.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import SwiftUI
import Charts

struct PieChart: UIViewRepresentable {
    
    // Only for summury chart
    var classification: String = ""
    var average: Double = 0
       
    // For all chart
    var isSummury = false // true면 과목or전체 평점 차트, false면 학점 분포 차트
    var entries: [PieChartDataEntry]
    
    let pieChart = PieChartView()
    
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.selectionShift = 0
        if isSummury {
            dataSet.colors = [UIColor(Color("pastelRed")),UIColor(Color("pastelLightGray"))]
        } else {
            dataSet.colors = [UIColor(Color("pastelRed")),UIColor(Color("pastelOrange")),UIColor(Color("pastelYellow")),UIColor(Color("pastelGreen")),UIColor(Color("pastelBlue")),UIColor(Color("pastelIndigo")),UIColor(Color("pastelPurple")),UIColor(Color("pastelDeepPurple")),UIColor(Color("pastelBrown")),UIColor(Color("pastelLightGray"))]
        }
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        configureChart(uiView)
        formatCenter(uiView)
        formatDataSet(dataSet)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChart
        init(parent: PieChart) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func configureChart( _ pieChart: PieChartView) {
        pieChart.rotationEnabled = false
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = !isSummury
        pieChart.entryLabelColor = UIColor.black
        pieChart.noDataText = "데이터 가저오는 중..."
        pieChart.holeRadiusPercent = isSummury ? 0.9 : 0
//        pieChart.centerText = "\(classification)학점\n\(String(format:"%.2f",average))" // 반올림
        pieChart.centerText = "\(classification)학점\n\(String(format:"%.2f",floor(Float(average)*100)/100))" // 내림
        pieChart.transparentCircleRadiusPercent = 0
        pieChart.legend.enabled = false // legend 비활성화
        pieChart.entryLabelFont = NSUIFont.systemFont(ofSize: NSUIFont.smallSystemFontSize)
    }
    
    func formatCenter(_ pieChart: PieChartView) {
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerTextRadiusPercent = 1
    }
    
    func formatDataSet(_ dataSet: ChartDataSet) {
        dataSet.drawValuesEnabled = false
    }
}

struct PieChart_Previews : PreviewProvider {
    static var previews: some View {
        PieChart(entries: [
                    PieChartDataEntry(value: 5, label: "A+"),
                    PieChartDataEntry(value: 4, label: "A"),
                    PieChartDataEntry(value: 1, label: "B+")])
            .frame(height: 200)
            .padding()
    }
}
