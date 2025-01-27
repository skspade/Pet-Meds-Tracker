import SwiftUI
import SwiftData
import CloudKit

@main
struct Pet_Meds_TrackerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let config = ModelConfiguration(for: Pet.self, Medication.self, MedicationHistory.self, cloudKitContainer: CKContainer.default())
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
