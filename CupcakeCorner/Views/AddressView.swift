//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import SwiftUI

struct AddressView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var order: Order
    
    @State private var fullName = ""
    @State private var streetLine1 = ""
    @State private var streetLine2 = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zip = ""
    
    init(order: Order) {
        self.order = order
        
        if let address = order.deliveryAddress {
            self._fullName = State(initialValue: address.fullName)
            self._streetLine1 = State(initialValue: address.streetLine1)
            self._streetLine2 = State(initialValue: address.streetLine2 ?? "")
            self._city = State(initialValue: address.city)
            self._state = State(initialValue: address.state)
            self._zip = State(initialValue: address.zip)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    TextField("Full name", text: $fullName)
                    TextField("Street", text: $streetLine1)
                    TextField("Street (optional)", text: $streetLine2)
                    TextField("City", text: $city)
                    
                    HStack(spacing: 16) {
                        TextField("State", text: $state)
                        TextField("Zip", text: $zip)
                            .keyboardType(.numberPad)
                    }
                }
                .textFieldStyle(CustomTextFieldStyle())
                .padding()
                .onSubmit(saveAddress)
            }
            .navigationTitle("Delivery address")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismiss) {
                        Text("Cancel")
                            .tertiaryButton()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: saveAddress) {
                        Text("Done")
                            .tertiaryButton()
                            .disabled(!isFormValid)
                    }
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !(fullName.isEmpty || streetLine1.isEmpty || city.isEmpty || state.isEmpty || zip.isEmpty)
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveAddress() {
        let address = Address(fullName: fullName, streetLine1: streetLine1, streetLine2: streetLine2, city: city, state: state, zip: zip)
        
        guard address.isValid else {
            return
        }
        
        order.deliveryAddress = address
        
        dismiss()
    }
}

extension AddressView {
    struct CustomTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(8)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
        
        AddressView(order: Order())
            .preferredColorScheme(.dark)
    }
}
