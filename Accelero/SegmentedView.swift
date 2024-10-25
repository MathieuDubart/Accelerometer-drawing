//
//  SegmentedView.swift
//  Accelero
//
//  Created by digital on 24/10/2024.
//

import SwiftUI

struct SegmentedView: View {
    var values = [String]()
    @Binding var selectedValue: String
    
    
    var body: some View {
        HStack {
            ForEach(values, id:\.self) {value in
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(value == self.selectedValue ? .orange : .clear)
                        .clipShape(.capsule)
                    Text(value)
                    
                }
                .frame(height: 30)
                .onTapGesture {
                    self.selectedValue = value
                }
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var source = ""
    SegmentedView(values: ["Poubelle", "Rond", "Carré", "Triangle"], selectedValue: $source)
}
