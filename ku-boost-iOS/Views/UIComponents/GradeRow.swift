//
//  GradeRow.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/12.
//

import SwiftUI

struct GradeRow: View {
    var grade: RealmGrade
    
    var body: some View {
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
                Spacer().frame(width:"0".widthOfString(usingFont: UIFont.systemFont(ofSize:UIFont.systemFontSize)))
            } else {
            }
        }
    }
    
}

struct GradeRow_Previews: PreviewProvider {

    static var previews: some View {
        GradeRow(grade: RealmGrade())
    }
}

extension String {

   func widthOfString(usingFont font: UIFont) -> CGFloat {
       let fontAttributes = [NSAttributedString.Key.font: font]
       let size = self.size(withAttributes: fontAttributes)
       return size.width
   }

}
