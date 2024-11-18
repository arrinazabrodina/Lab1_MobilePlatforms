//
//  EditInputView.swift
//  invest-return
//
//  Created by Arina Zabrodina on 11/11/2024.
//

import SwiftUI
import SwiftData

struct EditInputView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  let objectStore: ObjectStore
  let item: InputData?

  @State private var date: Date
  @State private var price: Double?
  @State private var returnRate: Double?
  @State private var currency: Currency?
  
  @State private var showingInputDataAlert = false
  @State private var showingInvalidRateAlert = false
  
  var isValid: Bool {
    currency != nil && price != nil && returnRate != nil
  }
  
  init(objectStore: ObjectStore) {
    self.objectStore = objectStore
    self.item = objectStore.configuration.data
    self.date = .now
    if let item {
      self.price = item.price
      self.returnRate = item.returnRate
      self.currency = item.currency
    }
  }
  
  var body: some View {
    VStack {
      DatePicker("Test", selection: $date)
      HStack {
        Text("Currency")
        Spacer()
        Menu(currency?.title ?? "Select") {
          ForEach(Currency.allCases) { currency in
            Button(currency.title, action: makeAction(for: currency))
          }
        }
      }
      HStack {
        Text("Price")
        Spacer()
        TextField("Enter price", value: $price, format: .number)
          .keyboardType(.decimalPad)
          .multilineTextAlignment(.trailing)
        Text(currency?.symbol ?? "")
          .foregroundColor(.primary)
      }
      HStack {
        Text("Return rate (% per year)")
        Spacer() 
        TextField("Enter", value: $returnRate, format: .number)
          .keyboardType(.decimalPad)
          .multilineTextAlignment(.trailing)
        Text("%")
          .foregroundColor(returnRate == nil ? Color.gray : .primary)
      }
      
    }.padding()
//      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Save") {
            guard isValid else {
              showingInputDataAlert = true
              return
            }
            
            guard (returnRate ?? .zero) > 0 else {
              showingInvalidRateAlert = true
              return
            }
            applyChanges()
            presentationMode.wrappedValue.dismiss()
          }
          .foregroundStyle(isValid ? Color.accentColor : Color.gray)
        }
      }
      .alert("You should enter all data before continuing",
             isPresented: $showingInputDataAlert,
             actions: {
        Button("OK", role: .cancel) { }
      })
      .alert("Rate should be greater than zero",
             isPresented: $showingInvalidRateAlert,
             actions: {
        Button("OK", role: .cancel) { }
      })
  }

  func makeAction(for currency: Currency) -> (() -> Void) {
    {
      self.currency = currency
    }
  }
  
  func applyChanges() {
    guard let price, let returnRate, let currency else { return }
    
    let item = self.item ?? .init(price: price, returnRate: returnRate, currency: currency)
    
    item.currency = currency
    item.price = price
    item.returnRate = returnRate
    
    objectStore.save(configuration: item)
  }
  
}

#Preview {
  NavigationStack {
    EditInputView(objectStore: .shared)
  }
}

