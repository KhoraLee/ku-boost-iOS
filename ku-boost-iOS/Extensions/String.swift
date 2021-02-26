//
//  String.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import SwiftUI

extension String {

  func sizeDiff(_ string: String, font: UIFont) -> CGFloat{
    string.widthOfString(usingFont: font) - widthOfString(usingFont: font)
  }

  func widthOfString(usingFont font: UIFont) -> CGFloat {
    let fontAttributes = [NSAttributedString.Key.font: font]
    let size = self.size(withAttributes: fontAttributes)
    return size.width
  }
}
