//
//  OpenSourceView.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/28.
//

import SwiftUI

struct OpenSourceView: View {

  var osl = ""

  var body: some View {
    ScrollView {
      Text(osl)
        .lineLimit(nil)
        .padding()
    }
  }
}
