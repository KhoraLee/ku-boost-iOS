//
//  String.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import SwiftUI

extension String {
    
    func sizeDiff(_ s:String,font:UIFont)-> CGFloat{
        return s.widthOfString(usingFont: font) - self.widthOfString(usingFont: font)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
