import SwiftUI
import SwiftData
import Foundation

struct PetDetailView: View {
    @Bindable var pet: Pet
    @State private var showingAddMedication = false
    
    var body: some View {
        List {
            Section("Pet Info") {
                TextField("Name", text: $pet.name)
                TextField("Species", text: $pet.species)
                DatePicker("Birthday", selection: $pet.birthday, displayedComponents: .date)
            }
            
            Section("Medications") {
                ForEach(pet.medications) { medication in
                    NavigationLink(destination: MedicationDetailView(medication: medication)) {
                        VStack(alignment: .leading) {
                            Text(medication.name)
                            Text(medication.schedule)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteMedications)
                
                Button(action: { showingAddMedication = true }) {
                    Label("Add Medication", systemImage: "plus")
                }
            }
        }
        .navigationTitle(pet.name)
        .sheet(isPresented: $showingAddMedication) {
            AddMedicationView(pet: pet)
        }
    }
    
    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                pet.medications.remove(at: index)
            }
        }
    }
}
