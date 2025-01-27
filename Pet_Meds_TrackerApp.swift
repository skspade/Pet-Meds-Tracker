import SwiftUI
import SwiftData

@main
struct Pet_Meds_TrackerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Pet.self, Medication.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
