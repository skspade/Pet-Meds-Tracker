import SwiftUI
import SwiftData
import Foundation

struct PetDetailView: View {
    @Bindable var pet: Pet
    @State private var showingAddMedication = false

    var body: some View {
        List {
            PetInfoSection(pet: pet)
            MedicationsSection(
                pet: pet,
                showingAddMedication: $showingAddMedication
            )
        }
        .navigationTitle(pet.name)
        .sheet(isPresented: $showingAddMedication) {
            AddMedicationView()
        }
    }
}
