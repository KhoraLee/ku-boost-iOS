//
//  BackBtn.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import SwiftUI

struct BackBtn: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.compact.left") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("primaryLightColor"))
            }
        }
    }
}
