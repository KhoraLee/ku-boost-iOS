//
//  CurrentGradeCardView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import SwiftUI
import Charts

struct GradeCardView: View {
    
    @ObservedObject var viewModel = GradeViewModel() // TODO : 뷰모델이 아닌 데이터를 binding 으로 받기
    
    // 성적 리스트
    // Pie 차트 데이터

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
                        PieChart(entries: [
                            PieChartDataEntry(value:4,label:"A+"),
                            PieChartDataEntry(value:4,label:"A"),
                            PieChartDataEntry(value:1,label:"B+")
                        ]).frame(height: proxy.size.width*0.8/3)
                        Spacer()
                        PieChart(entries: [
                            PieChartDataEntry(value:4,label:"A+"),
                            PieChartDataEntry(value:4,label:"A"),
                            PieChartDataEntry(value:1,label:"B+")
                        ]).frame(height: proxy.size.width*0.8/3)
                        Spacer()
                        PieChart(entries: [
                            PieChartDataEntry(value:4,label:"A+"),
                            PieChartDataEntry(value:4,label:"A"),
                            PieChartDataEntry(value:1,label:"B+")
                        ]).frame(height: proxy.size.width*0.8/3)
                    }
                    List{
                        ForEach(viewModel.curSemGrades, id: \.compoundKey ){grade in
                        GradeRow(grade: grade)
                        }
                    }.listStyle(PlainListStyle())
                    .environment(\.defaultMinListRowHeight, 40)
                    .frame(height: 40 * CGFloat(viewModel.curSemGrades.count))
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



//struct CurrentGradeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentGradeCardView()
//    }
//}
