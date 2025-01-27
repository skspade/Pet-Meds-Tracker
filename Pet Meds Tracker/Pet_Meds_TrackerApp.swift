//
//  Pet_Meds_TrackerApp.swift
//  Pet Meds Tracker
//
//  Created by Sean Spade on 1/22/25.
//

import SwiftUI
import SwiftData

@main
struct Pet_Meds_TrackerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let config = ModelConfiguration(for: Pet.self, Medication.self, MedicationHistory.self)
            container = try ModelContainer(for: Pet.self, Medication.self, MedicationHistory.self,
                                        configurations: config)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
