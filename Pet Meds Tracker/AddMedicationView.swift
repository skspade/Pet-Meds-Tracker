import SwiftUI
import SwiftData

struct AddMedicationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var pets: [Pet]
    @State private var medicationName = ""
    @State private var selectedPet: Pet?
    @State private var dosage = ""
    @State private var frequency = ""
    
    @State private var schedule: [Date] = [Date()]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Medication Name", text: $medicationName)
                TextField("Dosage", text: $dosage)
                
                Section("Schedule") {
                    ForEach(schedule.indices, id: \.self) { index in
                        DatePicker(
                            "Date \(index + 1)",
                            selection: $schedule[index],
                            displayedComponents: .date
                        )
                    }
                    
                    Button(action: { schedule.append(Date()) }) {
                        Label("Add Date", systemImage: "plus.circle")
                    }
                }
                
                Picker("Pet", selection: $selectedPet) {
                    ForEach(pets) { pet in
                        Text(pet.name).tag(pet as Pet?)
                    }
                }
            }
            .navigationTitle("New Medication")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addMedication()
                    }
                    .disabled(medicationName.isEmpty || schedule.isEmpty || dosage.isEmpty)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width > 100 {
                            dismiss()
                        }
                    }
            )
        }
    }
    
    private func addMedication() {
        guard let selectedPet = selectedPet else { return }
        
        let newMedication = Medication(
            name: medicationName,
            dosage: dosage,
            schedule: schedule
        )
        
        selectedPet.medications.append(newMedication)
        modelContext.insert(newMedication)
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    AddMedicationView()
        .modelContainer(for: [Medication.self, Pet.self])
}
