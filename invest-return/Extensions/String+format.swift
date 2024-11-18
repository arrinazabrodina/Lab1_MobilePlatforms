//
//  String+format.swift
//  invest-return
//
//  Created by Arina Zabrodina on 17/11/2024.
//

import Foundation

extension String {
  
  func format(_ args: CVarArg...) -> String {
    String(format: self, args)
  }
  
}

