//
//  CustomInt.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation
import RealmSwift

class CodableRealmInt: Object, Decodable{
    private var numeric = RealmOptional<Int>()

        required public convenience init(from decoder: Decoder) throws {
            self.init()

            let singleValueContainer = try decoder.singleValueContainer()
            if singleValueContainer.decodeNil() == false {
                let value = try singleValueContainer.decode(Int.self)
                numeric = RealmOptional(value)
            }
        }

        var value: Int? {
            return numeric.value
        }
}
