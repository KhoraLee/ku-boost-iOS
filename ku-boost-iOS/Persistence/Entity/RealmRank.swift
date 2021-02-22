//
//  RealmRank.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/21.
//

import RealmSwift

class RealmRank : Object {
    
    @objc dynamic var stdNo: String = "" // 학번
    @objc dynamic var year: Int = 0 // 년도
    @objc dynamic var semester: Int = 0 // 학기
    @objc dynamic var rank: Int = 0 // 등수
    @objc dynamic var total: Int = 0 // 총 인원
    
    @objc dynamic var compoundKey = "" // Compound Key
    
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(stdNo)-\(year)-\(semester)"
    }
    
}
