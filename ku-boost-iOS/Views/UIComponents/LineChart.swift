//
//  LineChart.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import SwiftUI
import Charts

struct LineChart: UIViewRepresentable {
        
    var entries: [ChartDataEntry]
    
    let lineChart = LineChartView()
    
    func makeUIView(context: Context) -> LineChartView {
        lineChart.delegate = context.coordinator
        return lineChart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        var dataSet = LineChartDataSet()
        if !(entries.count == 0) {
            dataSet = LineChartDataSet(entries: entries)
            let ChartData = LineChartData(dataSet: dataSet)
            uiView.data = ChartData
        }

        configureChart(uiView)
        formatCenter(uiView)
        formatDataSet(dataSet)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        var parent: LineChart
        init(parent: LineChart) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func configureChart( _ lineChart: LineChartView) {
        lineChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutQuad)
        lineChart.noDataText = "데이터 가저오는 중..."
        lineChart.legend.enabled = false // legend 비활성화
        lineChart.dragEnabled = false
        lineChart.highlightPerTapEnabled = false
        lineChart.highlightPerDragEnabled = false
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.enabled = false
        lineChart.doubleTapToZoomEnabled = false
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        
    }
    
    func formatCenter(_ lineChart: LineChartView) {
//        lineChart.backgroundColor = UIColor.systemBackground
    }
    
    func formatDataSet(_ dataSet: LineChartDataSet) {
        dataSet.colors = [UIColor(Color("pastelRed"))]
        dataSet.circleColors = [UIColor(Color("pastelRed"))]
        dataSet.circleRadius = 6
        dataSet.circleHoleRadius = 4
        dataSet.drawCircleHoleEnabled = true
        dataSet.lineWidth = 2
        dataSet.valueFormatter = customFormatter()
        dataSet.valueFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize*0.8)
    }
}

struct LineChart_Previews : PreviewProvider {
    static var previews: some View {
        LineChart(entries: [ChartDataEntry(x: 1, y: 4.3),ChartDataEntry(x: 2, y: 4.35)])
            .frame(height: 400)
            .padding()
    }
}

class customFormatter: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.2f", value)
    }
    
}
