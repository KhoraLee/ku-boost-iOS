//
//  QRResponse.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/09.
//

import Foundation

struct QRResponse: Codable {
    let qrdata: qrdata?
    
    enum CodingKeys: String, CodingKey {
        case qrdata = "data"
    }
}

struct qrdata: Codable {
    let membershipCard: String
}
