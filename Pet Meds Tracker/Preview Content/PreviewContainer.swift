import SwiftData

@MainActor
let PreviewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Pet.self, Medication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
