//
//  OrderView.swift
//  iDine
//
//  Created by Frueh Aaron, US-21 on 09.07.19.
//  Copyright © 2019 Robert Magnusson. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.price)€")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: CheckoutView().environmentObject(order)) {
                        Text("Place Order!")
                    }.disabled(order.items.count < 1)
                }
            }
            .navigationBarTitle("Order")
            .listStyle(.grouped)
        }
    }
}

#if DEBUG
struct OrderView_Previews: PreviewProvider {
    static let order = Order()

    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
#endif
