//
//  RealmSimulation.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation
import RealmSwift

class RealmSimulation : Object {
    
    @objc dynamic var stdNo: String = "" // 학번
    @objc dynamic var classification: String = "" // 이수구분
    @objc dynamic var remainder: Int = 0 // 잔여학점
    @objc dynamic var acquired: String = ""  // 취득학점
    @objc dynamic var standard: Int = 0 //기준학점
    
    @objc dynamic var compoundKey = "" // Compound Key
    
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func setup(simul:GraduationSimulation){
        self.stdNo = UserDefaults.stdNo
        self.classification = simul.classification ?? ""
        self.remainder = simul.remainder ?? 0
        self.acquired = simul.acquired ?? ""
        self.standard = simul.standard ?? 0
        
        self.compoundKey = compoundKeyValue()
     }

     func compoundKeyValue() -> String {
         return "\(stdNo)-\(classification)"
     }
    
}
