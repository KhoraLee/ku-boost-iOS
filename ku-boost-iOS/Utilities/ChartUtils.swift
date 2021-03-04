//
//  GradeUtil.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import Charts

class ChartUtils {

  static func makeGradeEntry(grades: [RealmGrade]) -> [PieChartDataEntry] {
    var tmp = [String:Int]()
    var pieEntries = [PieChartDataEntry]()

    for grade in grades {
      let key = grade.characterGrade
      if tmp[key] == nil{ tmp[key] = 0 }
      tmp[key] = tmp[key]! + 1
    }

    let sorted = tmp.sorted {
      if $0.value == $1.value{
        return $0.key.prefix(1) < $1.key.prefix(1)
      } else {
        return $0.value > $1.value
      }
    }
    sorted.forEach{ key,value in
      pieEntries.append(PieChartDataEntry(value: Double(value), label:key))
    }
    return pieEntries
  }

  static func makeSubjectEntry(grades: [RealmGrade], isMajor: Bool = false) -> [PieChartDataEntry] {
    var sum: Float = 0
    var count: Float = 0
    for grade in grades {
      if grade.evaluationMethod == "P/N평가" { continue }
      if isMajor {
        if grade.classification == "전필" || grade.classification == "전선" {
          sum += (grade.grade.value ?? 0) * Float(grade.subjectPoint.value ?? 0)
          count += Float(grade.subjectPoint.value ?? 0)
        }
      } else {
        sum += (grade.grade.value ?? 0) * Float(grade.subjectPoint.value ?? 0)
        count += Float(grade.subjectPoint.value ?? 0)
      }
    }
    if sum == 0 && count == 0 {
      return [
        PieChartDataEntry(value: 0, label:"grade"),
        PieChartDataEntry(value: 4.5, label:"total"),
      ]
    }
    return [
      PieChartDataEntry(value: Double(sum / count), label:"grade"),
      PieChartDataEntry(value: 4.5 - Double(sum / count), label:"total"),
    ]
  }

  static func makeGradeLineEntry(grades: [RealmGrade]) -> [ChartDataEntry]{
    var sum = [String:Float]()
    var count = [String:Float]()

    for grade in grades {
      if grade.evaluationMethod == "P/N평가" { continue }
      let key = "\(grade.year)\(grade.semester)"
      if sum[key] == nil {
        sum[key] = 0
        count[key] = 0
      }
      sum[key]! += (grade.grade.value ?? 0) * Float(grade.subjectPoint.value ?? 0)
      count[key]! += Float(grade.subjectPoint.value ?? 0)
    }

    let sorted = sum.sorted { $0.key < $1.key }
    var lineEntries = [ChartDataEntry]()

    var xValue = 0
    for (key,value) in sorted {
      let avg = value / count[key]!
      if value == 0 && count[key] == 0 { continue }
      lineEntries.append(ChartDataEntry(
        x: Double(xValue),
        y: Double(floor(Float(avg) * 100) / 100)))
      xValue += 1
    }
    return lineEntries
  }

}
