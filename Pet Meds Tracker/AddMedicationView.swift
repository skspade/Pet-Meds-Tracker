//
//  AddMedicationView.swift
//  Pet Meds Tracker
//
//  Created by Sean Spade on 1/25/25.
//

import SwiftUI
import SwiftData

struct AddMedicationView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    
    @State private var name = ""
    @State private var dosage = ""
    @State private var schedule: [Date] = [Date()]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Medication Name", text: $name)
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
                    .disabled(name.isEmpty || schedule.isEmpty || dosage.isEmpty)
                }
            }
        }
    }
    
    private func addMedication() {
        let medication = Medication(name: name, dosage: dosage, schedule: schedule)
        pet.medications.append(medication)
        dismiss()
    }
}

#Preview {
    AddMedicationView(pet: Pet)
}
