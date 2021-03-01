//
//  SettingViewModel.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/23.
//

import Combine
import CoreImage.CIFilterBuiltins
import PromiseKit
import SwiftUI

class SettingViewModel: ObservableObject, Identifiable {

  // MARK: Internal

  static let shared = SettingViewModel()

  let authRepo = AuthRepository.shared
  let libRepo = LibraryRepository.shared

  var libLogon = false

  @Published var profileImage = UIImage()
  @Published var qrImg = UIImage()

  func fetchQRData() {
    qrImg = UIImage()
    firstly{
      libLogon ? Promise() : libRepo.makeLoginRequest()
    }.then{
      self.libRepo.makeMobileQRCodeRequest()
    }.done{
      self.makeQRCode()
    }.catch{ err in
      print(err)
    }
  }

  func getProfileImage() {
    firstly{
      authRepo.makeStudentInformationRequest()
    }.done{
      let encoded = UserDefaults.photo
      self.profileImage = UIImage(data: Data(base64Encoded: encoded)!)!
    }.catch{ err in
      print(err)
    }
  }

  func makeQRCode() {
    let data = UserDefaults.qrRaw.data(using: .ascii)
    filter.setValue("M", forKey: "inputCorrectionLevel")
    filter.setValue(data, forKey: "inputMessage")
    if let outputImage = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 12, y: 12)) {
      if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        qrImg = UIImage(cgImage: cgimg)
        return
      }
    }
    qrImg = UIImage(systemName: "xmark.circle") ?? UIImage()
  }

  func logout() {
    authRepo.makeLogoutRequset()
  }

  func getOpenSourceLicense() -> String {
    if
      let filepath = Bundle.main.path(
        forResource: "Pods-ku-boost-iOS-acknowledgements",
        ofType: "markdown")
    {
      do {
        return try String(contentsOfFile: filepath)
      } catch let error as NSError {
        return "\(error.localizedDescription)"
      }
    } else {
      return "File not found"
    }
  }

  // MARK: Private

  private var disposables: Set<AnyCancellable> = []

  private let context = CIContext()
  private let filter = CIFilter.qrCodeGenerator()
}
