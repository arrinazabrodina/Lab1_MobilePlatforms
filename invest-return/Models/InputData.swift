//
//  Item.swift
//  invest-return
//
//  Created by Arina Zabrodina on 11/11/2024.
//

import Foundation
import SwiftData

enum Currency: String, Codable, CaseIterable, Identifiable {
  
  var id: Self { self }
  
  case uah, usd, eur
  
  var title: String { rawValue.uppercased() }
  
  var symbol: String {
    switch self {
    case .uah: return "₴"
    case .usd: return "$"
    case .eur: return "€"
    }
  }
  
}

final class Configuration {
  
  var data: InputData?
  
  init(data: InputData? = nil) {
    self.data = data
  }
  
}

@Model
final class InputData {
  
  var price: Double
  var returnRate: Double
  var currency: Currency
  
  init(price: Double, returnRate: Double, currency: Currency) {
    self.price = price
    self.returnRate = returnRate
    self.currency = currency
  }
  
  //  private init() { }
  
  //  static let empty: InputData = .init()
  
}
