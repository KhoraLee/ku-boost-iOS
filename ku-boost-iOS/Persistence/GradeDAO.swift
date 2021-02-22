//
//  GradeDAO.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/20.
//

import RealmSwift

class GradeDAO {
    static let shared = GradeDAO()
    
    private let realm = try! Realm()
    
    func insertGrade(grade: RealmGrade) {
        try? realm.write {
            realm.add(grade, update: .modified)
        }
    }
    
    func validateGrade(stdNo: String, subjectId: String) {
        let grade = realm.objects(RealmGrade.self).filter("stdNo == '\(stdNo)' && subjectId == '\(subjectId)'").first!
        try? realm.write {
            grade.validate()
        }
    }
    
    func getAllGrades(stdNo: String, valid: Bool = true) -> [RealmGrade] {
        return realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && valid == \(valid)")
            .toArray(ofType: RealmGrade.self)
    }
    
    func getCurrentSemester(stdNo: String) -> RealmGrade {
        return realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)'")
            .sorted(by: [SortDescriptor(keyPath: "year",ascending: false),SortDescriptor(keyPath: "semester",ascending: false)]).first!
    }
    
    func getCurrentSemesterGrades(stdNo: String) -> [RealmGrade] {
        let curSem = getCurrentSemester(stdNo: stdNo)
        return realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && year == \(curSem.year) && semester == \(curSem.semester)").toArray(ofType: RealmGrade.self)
    }
    
    func getSelectedSemesterGrades(stdNo: String, year: Int, semester: Int) -> [RealmGrade] {
        return realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && year == \(year) && semester == '\(semester)학기'").toArray(ofType: RealmGrade.self)
    }
    
    func getGradesByClassification(stdNo: String, clf: String, valid: Bool = true) -> [RealmGrade] {
        return realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && classification == '\(clf)' && valid == \(valid)").toArray(ofType: RealmGrade.self)
    }

    func removeGrades(stdNo: String, year: Int, semester: Int) {
        let entities = realm.objects(RealmGrade.self)
            .filter("stdNo == '\(stdNo)' && year == \(year) && semester == \(semester)")
        try? realm.write {
            realm.delete(entities)
        }
    }

    func getGradeBySubjectNumber(stdNo: String, subjectNumber: String) -> RealmGrade {
        return realm.objects(RealmGrade.self).filter("stdNo == '\(stdNo)' && subjectId == '\(subjectNumber)'").first!
    }

    func updateClassificationBySubjectNumber(stdNo: String, clf: String, subjectNumber: String, subjectArea: String = "") {
        let entity = getGradeBySubjectNumber(stdNo: stdNo, subjectNumber: subjectNumber)
        try? realm.write {
            entity.classification = clf
            if !subjectArea.isEmpty{
                entity.subjectArea = subjectArea
            }
        }
    }
    
}
