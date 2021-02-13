//
//  CurrentGradeCardView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/10.
//

import SwiftUI
import Charts

struct GradeCardView: View {
    
    @ObservedObject var viewModel = GradeViewModel()

    var proxy: GeometryProxy
    var title = ""
    
    @State var size: CGFloat = 3.2
    @State var rowSize: CGSize = .zero
    var body: some View {

        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    // Code Start Here
                    if title != ""{
                    Text("\(title)")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        
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
//                            .listRowInsets(EdgeInsets())
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
