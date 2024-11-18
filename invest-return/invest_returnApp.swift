//
//  invest_returnApp.swift
//  invest-return
//
//  Created by Arina Zabrodina on 11/11/2024.
//

import SwiftUI
import SwiftData

@main
struct invest_returnApp: App {
  
//  var sharedModelContainer: ModelContainer = {
//    let schema = Schema([
//      InputData.self,
//    ])
//    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
//    
//    do {
//      return try ModelContainer(for: schema, configurations: [modelConfiguration])
//    } catch {
//      fatalError("Could not create ModelContainer: \(error)")
//    }
//  }()
  
  let objectStore = ObjectStore.shared
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ContentView(objectStore: objectStore)
      }
    }
  }
  
  
}
