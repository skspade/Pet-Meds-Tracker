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

// MARK: - Pet Info Section
private struct PetInfoSection: View {
    @Bindable var pet: Pet

    var body: some View {
        Section("Pet Info") {
            TextField("Name", text: $pet.name)
            TextField("Species", text: $pet.species)
            BirthdayPicker(pet: pet)
        }
    }
}

private struct BirthdayPicker: View {
    @Bindable var pet: Pet

    var body: some View {
        let birthDate = Binding(
            get: { pet.birthDate ?? Date() },
            set: { pet.birthDate = $0 }
        )
        DatePicker("Birthday", selection: birthDate, displayedComponents: .date)
    }
}

// MARK: - Medications Section
private struct MedicationsSection: View {
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
        ForEach(pet.medications) { medication in
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

private struct MedicationRow: View {
    let medication: Medication
    
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"  // Customize format as needed

        return formatter
    }
    
    var body: some View {
        let formatter = dateFormatter()
        
        VStack(alignment: .leading) {
            Text(medication.name)
            Text(medication.schedule.map{ formatter.string(from: $0)}.joined(separator: ", "))
                .font(.caption)
                .foregroundStyle(.secondary)
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
