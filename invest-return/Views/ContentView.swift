//
//  ContentView.swift
//  invest-return
//
//  Created by Arina Zabrodina on 11/11/2024.
//

import SwiftUI
import SwiftData
import Charts

struct ContentView: View {
  
  let configuration: Configuration
  let objectStore: ObjectStore
//  @Query private var items: [InputData]
  
  init(objectStore: ObjectStore) {
    self.objectStore = objectStore
    self.configuration = objectStore.configuration
  }
  
  var body: some View {
    ZStack {
      if let data = configuration.data {
        makeChart(from: data)
      }
      else {
        VStack {
          Text("No item")
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        NavigationLink {
          EditInputView(objectStore: objectStore)
        } label: {
          Image(systemName: "pencil")
        }

      }
    }
  }
  
  func makeChart(from data: InputData) -> some View {
    VStack {
      let exponentialData = calculate(from: data)
      Chart {
        ForEach(exponentialData) { point in
          LineMark(
            x: .value("Year", point.x),
            y: .value("Amount", point.y)
          )
        }
      }
      .frame(height: 200)
      .padding()
      
      Text("Years to return price: %.0f".format(exponentialData.last?.x ?? 1))
      
      Text("Price: \(data.price, specifier: "%.2f") \(data.currency.symbol)")
      Text("Return rate: \(data.returnRate, specifier: "%.2f")%")
      Text("Currency: \(data.currency.title)")
    }
  }
  
}



private extension ContentView {
  
  func calculate(from data: InputData) -> [Point] {
    var result: [Point] = []
    
    let rate = data.returnRate / 100 + 1.0
    guard rate > 1 else { return [] }
    
    var currentYear: Double = 0
    var currentMoney: Double = data.price
    result.append(.init(x: currentYear, y: currentMoney))
    
    while currentMoney < data.price * 2 {
      currentYear += 1
      currentMoney = currentMoney * rate
      
      result.append(.init(x: currentYear, y: currentMoney))
    }
    
    return result
  }
  
  func currentYear() -> Int {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: .now)
    
    return year
  }
  
}

#Preview {
  NavigationStack {
    ContentView(objectStore: .shared)
  }
}
