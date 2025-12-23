//
//  ShoeStore.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import Foundation
import Combine

final class ShoeStore: ObservableObject {
    @Published var shoes: [Shoe] = []

    func addShoe(shoe: Shoe) {
        shoes.append(shoe)
    }

    func getShoe(for id: UUID?) -> Shoe? {
        guard let id else { return nil }
        return shoes.first { $0.id == id }
    }
    
    func getAllShoes() -> [Shoe] {
        shoes
    }
}
