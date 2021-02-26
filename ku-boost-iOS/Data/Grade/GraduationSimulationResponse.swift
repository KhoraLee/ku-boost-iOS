//
//  GraduationSimulationResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/08.
//

import Foundation

struct GraduationSimulationResponse: Codable{
  let simulations: [GraduationSimulation]

  enum CodingKeys: String, CodingKey {
    case simulations = "DS_SIMUL1"
  }
}
