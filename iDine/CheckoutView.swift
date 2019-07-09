//
//  CheckoutView.swift
//  iDine
//
//  Created by Frueh Aaron, US-21 on 09.07.19.
//  Copyright © 2019 Robert Magnusson. All rights reserved.
//

import SwiftUI

struct CheckoutView : View {
    @EnvironmentObject var order: Order
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 2
    @State private var showingPaymentAlert = false

    var orderPrice: Double {
        Double(order.total)
    }

    var tipPrice: Double {
        orderPrice / 100 * Double(Self.tipAmounts[tipAmount])
    }

    var totalPrice: Double {
        orderPrice + tipPrice
    }

    static let paymentTypes = ["Cash", "Credit Card", "PayPal", "iDine Points"]
    static let tipAmounts = [0, 5, 10, 15, 20, 25]

    var body: some View {
        Form {
            Section(header: Text("Payment Details")) {
                Picker(selection: $paymentType, label: Text("How do you want to pay?")) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }

                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add iDine loyality card")
                }

                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }

            Section(header: Text("Add a tip?")) {
                SegmentedControl(selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }
            }

            Section(header: Text("Total \(totalPrice, specifier: "%.2f")€")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            ) {
                Text("Order total: \(orderPrice, specifier: "%.2f")€")
                Text("Tip: \(tipPrice, specifier: "%.2f")€")
                Button(action: {
                    self.showingPaymentAlert.toggle()
                }) {
                    Text("Confirm Order")
                }
            }
        }.navigationBarTitle("Payment", displayMode: .inline)
            .presentation($showingPaymentAlert) {
                Alert(title: Text("Order Confirmed"), message: Text("Your total was \(totalPrice, specifier: "%.2f")€ - thank you!"), dismissButton: .default(Text("OK")))
            }
    }
}

#if DEBUG
struct CheckoutView_Previews : PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
#endif
