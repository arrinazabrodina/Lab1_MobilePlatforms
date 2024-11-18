//
//  ObjectStore.swift
//  invest-return
//
//  Created by Arina Zabrodina on 11/11/2024.
//

import Foundation
import SwiftData

@MainActor final class ObjectStore {
  
  let modelContainer: ModelContainer = {
    let schema = Schema([
      InputData.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  static let shared = ObjectStore()
  
  let configuration: Configuration
  
  private var configurations: [InputData] {
    (try? modelContainer.mainContext.fetch(.init())) ?? []
  }
  
  private init() {
    self.configuration = .init()
    self.configuration.data = configurations.first
  }
  
  func save(configuration: InputData) {
    do {
      if configuration.modelContext == nil {
        modelContainer.mainContext.insert(configuration)
        self.configuration.data = configuration
      }
      try modelContainer.mainContext.save()
    }
    catch {
      print(error)
    }
  }
  
}
