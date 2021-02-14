//
//  TotalGradeCardView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import SwiftUI
import Charts

struct TotalGradeCardView: View {
      
    // Pie charts entries
    var pieChartEntries: [[PieChartDataEntry]] // [0] : 전체 학점, [1] : 전공 학점, [2]: 학점 분포
    
    // Line chart entries
    var lineChartEntries: [ChartDataEntry]
    
    // 학기 성적 전체 리스트
    var grades: [RealmGrade]

    var proxy: GeometryProxy
    var title = ""
       
    var body: some View {

        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    // Card view starts here
                    HStack{
                        if title != ""{
                            Text("\(title)")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                        }
                        Spacer()
                        NavigationLink(destination: TotalGradeDetailView()) {
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIFont.systemFontSize * 2)
                                .foregroundColor(Color("primaryColor"))
                        }
                        
                    }
                    HStack{
                        PieChart(classification:"전체", average: pieChartEntries[0][0].value, isSummury: true, entries: pieChartEntries[0])
                            .frame(height: proxy.size.width*0.8/3)
                        Spacer()
                        PieChart(classification:"전공", average: pieChartEntries[1][0].value, isSummury: true, entries: pieChartEntries[1])
                            .frame(height: proxy.size.width*0.8/3)
                        Spacer()
                        PieChart(entries: pieChartEntries[2])
                            .frame(height: proxy.size.width*0.8/3)
                    }
                    LineChart(entries: lineChartEntries)
                        .frame(height: proxy.size.width*1.6/3)
                    // End
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
       )
        .padding([.top, .horizontal])

    }
}
