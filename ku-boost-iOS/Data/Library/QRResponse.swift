//
//  QRResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation

// MARK: - QRResponse

struct QRResponse: Codable {
  let qrdata: qrdata?

  enum CodingKeys: String, CodingKey {
    case qrdata = "data"
  }
}

// MARK: - qrdata

// swiftlint:disable:next type_name
struct qrdata: Codable {
  let membershipCard: String
}
