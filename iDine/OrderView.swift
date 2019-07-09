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

    var orderControlsDisabled: Bool {
        return order.items.count < 1
    }

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
                    }.onDelete(perform: deleteOrderItem)
                }

                Section {
                    NavigationLink(destination: CheckoutView().environmentObject(order)) {
                        Text("Place Order!")
                    }.disabled(orderControlsDisabled)
                }
            }
            .navigationBarTitle("Order")
            .navigationBarItems(trailing: EditButton().disabled(orderControlsDisabled))
            .listStyle(.grouped)
        }
    }

    func deleteOrderItem(at offset: IndexSet) {
        if let first = offset.first {
            order.items.remove(at: first)
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
