//
//  UITextField+Extensions.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/23.
//

import JVFloatLabeledTextField

extension JVFloatLabeledTextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
