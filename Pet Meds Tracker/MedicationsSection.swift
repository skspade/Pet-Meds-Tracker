import SwiftUI
import SwiftData

struct MedicationsSection: View {
    @Bindable var pet: Pet
    @Binding var showingAddMedication: Bool
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Section("Medications") {
            MedicationsList(pet: pet, modelContext: modelContext)
            AddMedicationButton(showingAddMedication: $showingAddMedication)
        }
    }
}

private struct MedicationsList: View {
    @Bindable var pet: Pet
    let modelContext: ModelContext
    
    var sortedMedications: [Medication] {
        pet.medications.sorted { med1, med2 in
            let date1 = med1.schedule.first ?? .distantFuture
            let date2 = med2.schedule.first ?? .distantFuture
            return date1 < date2
        }
    }

    var body: some View {
        ForEach(sortedMedications) { medication in
            NavigationLink(destination: MedicationDetailView(medication: medication)) {
                MedicationRow(medication: medication)
            }
        }
        .onDelete(perform: deleteMedications)
    }

    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let medication = sortedMedications[index]
                pet.medications.removeAll { $0.id == medication.id }
                modelContext.delete(medication)
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
