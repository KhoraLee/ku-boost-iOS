//
//  RankDAO.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import RealmSwift

class RankDAO {
    static let shared = RankDAO()
    
    private let realm = try! Realm()
    
    func insertRank(rank: RealmRank) {
        try? realm.write {
            realm.add(rank, update: .modified)
        }
    }
    
    func getRank(stdNo: String, year: Int, semester: Int) -> RealmRank {
        return realm.objects(RealmRank.self)
            .filter("stdNo == '\(stdNo)' && year == \(year) && semester == \(semester)")
            .first!
    }
}
