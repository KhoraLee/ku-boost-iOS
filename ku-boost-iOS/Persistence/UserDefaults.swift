//
//  PreferenceManager.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/21.
//

import Foundation

// MARK: - UserDefault

@propertyWrapper
struct UserDefault<Value> {
  let key: String
  let defaultValue: Value
  var container: UserDefaults = .standard

  var wrappedValue: Value {
    get {
      container.object(forKey: key) as? Value ?? defaultValue
    }
    set {
      container.set(newValue, forKey: key)
    }
  }
}

extension UserDefaults {

  @UserDefault(key:"id", defaultValue:"")
  static var id: String

  @UserDefault(key:"cookie", defaultValue:"")
  static var cookie: String

  @UserDefault(key:"name", defaultValue:"")
  static var name: String

  @UserDefault(key:"stdNo", defaultValue:"")
  static var stdNo: String

  @UserDefault(key:"state", defaultValue:"")
  static var state: String

  @UserDefault(key:"dept", defaultValue:"")
  static var dept: String

  @UserDefault(key:"code", defaultValue:"")
  static var code: String

  @UserDefault(key:"hasData", defaultValue:false)
  static var hasData: Bool

  @UserDefault(key:"authToken", defaultValue: "")
  static var authToken: String

  @UserDefault(key:"qrRaw", defaultValue: "")
  static var qrRaw: String

  static func setUserInfo(
    name: String?,
    stdNo: String?,
    state: String?,
    dept: String?,
    code: String?)
  {
    UserDefaults.name = name ?? ""
    UserDefaults.stdNo = stdNo ?? ""
    UserDefaults.state = state ?? ""
    UserDefaults.dept = dept ?? ""
    UserDefaults.code = code ?? ""
  }

  static func clearAll() {
    setUserInfo(name: "", stdNo: "", state: "", dept: "", code: "")
    UserDefaults.id = ""
    UserDefaults.cookie = ""
    UserDefaults.authToken = ""
    UserDefaults.hasData = false
    KeyChain.shared.deletePassword()
  }
}
