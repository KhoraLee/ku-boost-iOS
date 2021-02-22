//
//  GradeRow.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/12.
//

import SwiftUI

struct GradeRow: View {
    var grade: RealmGrade
    @State var isTapped = false
    var body: some View {
        ZStack{
            HStack{
                Text(grade.subjectName)
                    .font(.callout)
                    .lineLimit(1)
                Spacer()
                Text(grade.professor)
                    .font(.callout)
                Text(String(grade.subjectPoint.value ?? 0))
                        .font(.callout)
                Text(grade.classification)
                    .font(.callout)
                Text(grade.characterGrade)
                    .font(.callout)
                if(grade.characterGrade.last != "+"){
                    Spacer().frame(width:"+".widthOfString(usingFont: UIFont.systemFont(ofSize:UIFont.systemFontSize)))
                } else {
                }
            }.contentShape(Rectangle())
            .onTapGesture {
                isTapped = true
            }
            NavigationLink(destination: GradeDetailView(grade: grade),isActive:$isTapped){
                EmptyView()
            }.hidden()
        }
    }
    
}

struct GradeRow_Previews: PreviewProvider {

    static var previews: some View {
        GradeRow(grade: RealmGrade())
    }
}
