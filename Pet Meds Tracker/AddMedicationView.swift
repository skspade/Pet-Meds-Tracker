import SwiftUI
import SwiftData

struct AddMedicationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var pets: [Pet]
    @State private var medicationName = ""
    @State private var selectedPet: Pet?
    @State private var dosageAmount: Double = 0.0
    @State private var dosageUnit: DosageUnit = .mg
    @State private var schedule: [Date] = [Date()]
    @State private var selectedMedication: Medication?
    @State private var isExistingMedication = false
    @ObservedObject var medicationStore: MedicationStore
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select Medication", selection: $selectedMedication) {
                    Text("New Medication").tag(Medication?.none)
                    ForEach(medicationStore.getAllMedications()) { medication in
                        Text(medication.name).tag(medication as Medication?)
                    }
                }
                .onChange(of: selectedMedication) { newValue in
                    isExistingMedication = newValue != nil
                    if let medication = newValue {
                        medicationName = medication.name
                        dosageAmount = medication.dosageAmount
                        dosageUnit = medication.dosageUnit
                        schedule = medication.schedule
                    } else {
                        medicationName = ""
                        dosageAmount = 0.0
                        dosageUnit = .mg
                        schedule = [Date()]
                    }
                }
                
                if !isExistingMedication {
                    TextField("Medication Name", text: $medicationName)
                    TextField("Dosage Amount", value: $dosageAmount, format: .number)
                    
                    Picker("Dosage Unit", selection: $dosageUnit) {
                        ForEach(DosageUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    
                    Section("Schedule") {
                        ForEach(schedule.indices, id: \.self) { index in
                            DatePicker(
                                "Date \(index + 1)",
                                selection: $schedule[index],
                                displayedComponents: [.date, .hourAndMinute]
                            )
                        }
                        
                        Button(action: { schedule.append(Date()) }) {
                            Label("Add Date", systemImage: "plus.circle")
                        }
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
                    .disabled(medicationName.isEmpty || schedule.isEmpty || dosageAmount <= 0)
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
        
        if let selectedMedication = selectedMedication {
            selectedPet.medications.append(selectedMedication)
        } else {
            let newMedication = Medication(
                name: medicationName,
                dosageAmount: dosageAmount,
                dosageUnit: dosageUnit,
                schedule: schedule
            )
            selectedPet.medications.append(newMedication)
            modelContext.insert(newMedication)
            medicationStore.addMedication(newMedication)
        }
        
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    AddMedicationView(medicationStore: MedicationStore())
        .modelContainer(for: [Medication.self, Pet.self])
}
