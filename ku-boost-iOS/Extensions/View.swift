//
//  View.swift
//  ku-boost-iOS
//
//  Created by 승윤이 on 2021/02/14.
//

import SwiftUI

// MARK: - UINavigationController + UIGestureRecognizerDelegate

extension UINavigationController: UIGestureRecognizerDelegate {

  // MARK: Open

  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

  // MARK: Public

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    viewControllers.count > 2
  }
}

extension View {
  func hasScrollEnabled(_ value: Bool) -> some View {
    onAppear {
      UITableView.appearance().isScrollEnabled = value
    }
  }
}

// MARK: - SizePreferenceKey

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero

  static func reduce(value: inout Value, nextValue: () -> Value) {
    value = nextValue()
  }
}
