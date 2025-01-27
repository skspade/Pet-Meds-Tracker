import SwiftUI

struct MedicationsSection: View {
    @Bindable var pet: Pet
    @Binding var showingAddMedication: Bool

    var body: some View {
        Section("Medications") {
            MedicationsList(pet: pet)
            AddMedicationButton(showingAddMedication: $showingAddMedication)
        }
    }
}

private struct MedicationsList: View {
    @Bindable var pet: Pet

    var body: some View {
        ForEach(pet.medications.sorted(by: { $0.schedule.first ?? Date() < $1.schedule.first ?? Date() })) { medication in
            NavigationLink(destination: MedicationDetailView(medication: medication)) {
                MedicationRow(medication: medication)
            }
        }
        .onDelete(perform: deleteMedications)
    }

    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                pet.medications.remove(at: index)
            }
        }
    }
}

private struct AddMedicationButton: View {
    @Binding var showingAddMedication: Bool

    var body: some View {
        Button(action: { showingAddMedication = true }) {
            Label("Add Medication", systemImage: "plus")
        }
    }
}
