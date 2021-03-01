//
//  KeyChain.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/28.
//

import Foundation
import Security

final class KeyChain {

  // MARK: Internal

  // MARK: Shared instance
  static let shared = KeyChain()

  func storePassword(password: String)  {
    guard let encodedPassword = password.data(using: .utf8) else { return }
    guard var query = self.query else { return }
    var status = SecItemCopyMatching(query as CFDictionary, nil)
    print(status)
    switch status {
    case errSecSuccess:
      var attributesToUpdate: [CFString: Any] = [:]
      attributesToUpdate[kSecAttrGeneric] = encodedPassword
      status = SecItemUpdate(
        query as CFDictionary,
        attributesToUpdate as CFDictionary)
      if status != errSecSuccess { return }
    case errSecItemNotFound:
      query[kSecAttrGeneric] = encodedPassword
      status = SecItemAdd(query as CFDictionary, nil)
      if status != errSecSuccess { return }
    default:
      return
    }

  }

  func getPassword() -> String? {
    guard let service = self.service else { return nil }
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecMatchLimit: kSecMatchLimitOne,
      kSecReturnAttributes: true,
      kSecReturnData: true,
    ]

    var item: CFTypeRef?
    if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
    guard
      let existingItem = item as? [String: Any],
      let passwordData = existingItem[kSecAttrGeneric as String] as? Data,
      let password = String(data: passwordData, encoding: .utf8) else { return nil }

    return password
  }

  func deletePassword() {
    guard let query = self.query else { return }
    SecItemDelete(query as CFDictionary)
  }

  // MARK: Private

  private let account = UserDefaults.id
  private let service = Bundle.main.bundleIdentifier

  private lazy var query: [CFString: Any]? = {
    guard let service = self.service else { return nil }
    return [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
    ]
  }()

}
