//
//  PieChart.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import SwiftUI
import Charts

struct PieChart: UIViewRepresentable {
    
    var entries: [PieChartDataEntry]
    let pieChart = PieChartView()
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.selectionShift = 0
        dataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        configureChart(uiView)
        formatCenter(uiView)
        formatLegend(uiView.legend)
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
        pieChart.drawEntryLabelsEnabled = false
        pieChart.holeRadiusPercent = 0.92
        pieChart.centerText = "차트 테스트"
        pieChart.transparentCircleRadiusPercent = 0
        pieChart.highlightPerTapEnabled = false
    }
    
    func formatCenter(_ pieChart: PieChartView) {
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerTextRadiusPercent = 1
    }
    
    func formatDescription( _ description: Description) {
        description.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func formatLegend(_ legend: Legend) {
        legend.enabled = false
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
