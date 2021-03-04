//
//  GraduationSimulationDAO.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import RealmSwift

class GraduationSimulationDAO {

  // MARK: Internal

  static let shared = GraduationSimulationDAO()

  func insertGraduationSimulation(simul: RealmSimulation) {
    try? realm.write {
      realm.add(simul, update: .modified)
    }
  }

  func loadGraduationSimulation(stdNo: String) -> [RealmSimulation]{
    realm.objects(RealmSimulation.self)
      .filter("stdNo == '\(stdNo)'")
      .toArray(ofType: RealmSimulation.self)
      .sorted(by: { $0.index < $1.index })
  }

  // MARK: Private

  private let realm = try! Realm()
}
