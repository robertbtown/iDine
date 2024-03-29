//
//  Order.swift
//  iDine
//
//  Created by Paul Hudson on 27/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import SwiftUI
import Combine

class Order: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    var items = [MenuItem]() {
        didSet {
            didChange.send()
        }
    }

    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }

    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }

    func containsFavourite(item: MenuItem) -> Bool {
        return favoriteMenuItems.contains(item)
    }

    func addFavourite(item: MenuItem) {
        favoriteMenuItems.append(item)
    }

    func removeFavourite(item: MenuItem) {
        if let index = favoriteMenuItems.firstIndex(of: item) {
            favoriteMenuItems.remove(at: index)
        }
    }

    var favoriteMenuItems: [MenuItem] = [] {
        didSet {
            didChange.send()
        }
    }
}
