//
//  BasicDrowdownMenu.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/8/25.
//

import SwiftUI

struct BasicDropdownMenu<T: Hashable & CustomStringConvertible>: View {
    let options: [T]
    @Binding var selection: T

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option.description) {
                    selection = option
                }
            }
        } label: {
            Label(selection.description, systemImage: "chevron.down")
        }
    }
}
