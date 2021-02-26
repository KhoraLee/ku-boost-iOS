//
//  RankDAO.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import RealmSwift

class RankDAO {

  // MARK: Internal

  static let shared = RankDAO()

  func insertRank(rank: RealmRank) {
    try? realm.write {
      realm.add(rank, update: .modified)
    }
  }

  func getRank(stdNo: String, year: Int, semester: Int) -> RealmRank {
    realm.objects(RealmRank.self)
      .filter("stdNo == '\(stdNo)' && year == \(year) && semester == \(semester)")
      .first!
  }

  // MARK: Private

  private let realm = try! Realm()
}
