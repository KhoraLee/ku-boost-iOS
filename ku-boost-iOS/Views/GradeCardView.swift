//
//  CurrentGradeCardView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import SwiftUI
import Charts

struct GradeCardView: View {
      
    // 계산된 pie chart entry들
    var gradeEntries: [[PieChartDataEntry]] // [0] : 전체 학점, [1] : 전공 학점, [2]: 학점 분포

    // 학기 성적 전체 리스트
    var grades: [RealmGrade]

    var proxy: GeometryProxy
    var title = ""
       
    var body: some View {

        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    // Card view starts here
                    if title != ""{
                        Text("\(title)")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                    HStack{
                        PieChart(classification:"전체", average: gradeEntries[0][0].value, isSummury: true, entries: gradeEntries[0])
                            .frame(height: proxy.size.width*0.8/3)
                        Spacer()
                        PieChart(classification:"전공", average: gradeEntries[1][0].value, isSummury: true, entries: gradeEntries[1])
                            .frame(height: proxy.size.width*0.8/3)
                        Spacer()
                        PieChart(entries: gradeEntries[2])
                            .frame(height: proxy.size.width*0.8/3)
                    }
                    List{
                        ForEach(grades, id: \.compoundKey ){grade in
                        GradeRow(grade: grade)
                        }
                    }.listStyle(PlainListStyle())
                    .environment(\.defaultMinListRowHeight, 40)
                    .frame(height: 40 * CGFloat(grades.count))
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
