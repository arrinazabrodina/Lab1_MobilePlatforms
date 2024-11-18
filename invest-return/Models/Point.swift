//
//  Point.swift
//  invest-return
//
//  Created by Arina Zabrodina on 17/11/2024.
//

import Foundation

struct Point: Identifiable {
  
  var id: String { "\(x):\(y)"}
  
  let x: Double
  let y: Double
  
}
