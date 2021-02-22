//
//  GraduationSimulationDAO.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/22.
//

import RealmSwift

class GraduationSimulationDAO {
    static let shared = GraduationSimulationDAO()
    
    private let realm = try! Realm()
    
    func insertGraduationSimulation(simul: RealmSimulation) {
        try? realm.write {
            realm.add(simul, update: .modified)
        }
    }
    
    func loadGraduationSimulation(stdNo: String) -> [RealmSimulation]{
        return realm.objects(RealmSimulation.self)
            .filter("stdNo == '\(stdNo)'")
            .toArray(ofType: RealmSimulation.self)
    }
}
