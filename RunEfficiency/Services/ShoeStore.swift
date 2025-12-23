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
    
    //Remove this
    init() {
        addShoe(shoe: Shoe(name: "NB Rebel", brand: "New Balance", stackHeightMm: 35.0, dropMm: 6.0, hasCarbonPlate: false))
        addShoe(shoe: Shoe(name: "NB SC Elite", brand: "New Balance", stackHeightMm: 39.0, dropMm: 6.0, hasCarbonPlate: true))
    }

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
