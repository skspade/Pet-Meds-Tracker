import SwiftUI

struct MedicationsSection: View {
    @Bindable var pet: Pet
    @Binding var showingAddMedication: Bool

    var body: some View {
        Section(MedicationStrings.sectionTitle) {
            MedicationsList(pet: pet)
            AddMedicationButton(showingAddMedication: $showingAddMedication)
        }
    }
}

private struct MedicationsList: View {
    @Bindable var pet: Pet

    var body: some View {
        ForEach(pet.medications.sorted()) { medication in
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
            Label(MedicationStrings.addMedication, systemImage: "plus")
        }
    }
}

// Extension to make medications sortable
extension Medication: Comparable {
    public static func < (lhs: Medication, rhs: Medication) -> Bool {
        let lhsDate = lhs.schedule.first ?? .distantFuture
        let rhsDate = rhs.schedule.first ?? .distantFuture
        return lhsDate < rhsDate
    }
}
