//
//  CustomFloat.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation
import RealmSwift

class CodableRealmFloat: Object, Decodable{
    private var numeric = RealmOptional<Float>()

        required public convenience init(from decoder: Decoder) throws {
            self.init()

            let singleValueContainer = try decoder.singleValueContainer()
            if singleValueContainer.decodeNil() == false {
                let value = try singleValueContainer.decode(Float.self)
                numeric = RealmOptional(value)
            }
        }

        var value: Float? {
            return numeric.value
        }
}
