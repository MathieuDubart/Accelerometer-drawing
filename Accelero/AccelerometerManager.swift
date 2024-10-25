//
//  AccelerometerManager.swift
//  Accelero
//
//  Created by digital on 24/10/2024.
//

import SwiftUI
import CoreMotion
import Combine

struct AccelerometerValues: Equatable, Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
    let z: Double
    let timestamp: Date
    
    func toString() -> String {
        return "x:\(String(format: "%.2f", self.x)) y:\(String(format: "%.2f", self.y)) z:\(String(format: "%.2f", self.z))"
    }
}


class AccelerometerManager: ObservableObject {
    private var motionManager = CMMotionManager()
    
    
    @Published var accelerometerValues = AccelerometerValues(x: 0, y: 0, z: 0, timestamp: Date.now)
    @Published var position: String = "Stable"
    @Published var accelerometerData: [AccelerometerValues] = []
    
    private var register: Bool = false
    
    init() {
        startAccelerometerUpdates()
    }
    
    private func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] data, error in
                guard let data = data else { return }
                let newValues = AccelerometerValues(x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z, timestamp: Date.now)
                self?.accelerometerValues = newValues
                if let bool = self?.register {
                    if bool {
                        self?.accelerometerData.append(newValues)
                    }
                }
                self?.updatePosition()
            }
        }
    }
    
    func registerValues() {
        self.register.toggle()
    }
    
    private func updatePosition() {
        let threshold: Double = 0.5 // Ajustez ce seuil selon vos besoins
        
        if accelerometerValues.z > threshold {
            position = "Haute"
        } else if accelerometerValues.z < -threshold {
            position = "Basse"
        } else if accelerometerValues.x > threshold {
            position = "Droite"
        } else if accelerometerValues.x < -threshold {
            position = "Gauche"
        } else {
            position = "Stable"
        }
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}
