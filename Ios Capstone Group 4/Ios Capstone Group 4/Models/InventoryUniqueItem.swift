//
//  InventoryUniqueItem.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/20/26.
//
import SwiftUI
struct InventoryUniqueItem: Identifiable, Hashable{
    var id = UUID()
    var inventory: Inventory


static func == (lhs: InventoryUniqueItem, rhs: InventoryUniqueItem) -> Bool {
    lhs.id == rhs.id
}
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
