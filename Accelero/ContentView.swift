//
//  ContentView.swift
//  Accelero
//
//  Created by digital on 24/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var accelerometerManager = AccelerometerManager()
    @State var isRecording: Bool = false
    @State var selectedSegment: String = ""
    
    var body: some View {
        VStack {
            
            SegmentedView(values:["Poubelle", "Rond", "Carré", "Triangle"], selectedValue: $selectedSegment)
            Text("Selected segment: \(selectedSegment)")
            
            Spacer()
            
            TurtleView(orientation: $accelerometerManager.position)
            
            Spacer()
            
            AccelerometerChart()
                .environmentObject(accelerometerManager)
            
            Spacer()
            
            Text(isRecording ? "Stop" : "Record")
                .font(.title)
                .foregroundStyle(.red)
                .onTapGesture {
                    self.isRecording.toggle()
                    accelerometerManager.registerValues()
                }
            
            Spacer()
                .frame(height: 50)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
