import SwiftUI
import SwiftData
import Foundation


struct AddPetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var species = ""
    @State private var birthday = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Pet Name", text: $name)
                TextField("Species", text: $species)
                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
            }
            .navigationTitle("New Pet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addPet()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func addPet() {
        let pet = Pet(name: name, species: species, birthday: birthday)
        modelContext.insert(pet)
        dismiss()
    }
}
