import SwiftUI
import SwiftData
import Foundation


struct AddPetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var species = ""
    @State private var birthDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Pet Name", text: $name)
                TextField("Species", text: $species)
                DatePicker("Birthday", selection: $birthDate, displayedComponents: .date)
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
    
    private func addPet() {
        let pet = Pet(name: name, species: species, birthDate: birthDate)
        modelContext.insert(pet)
        dismiss()
    }
}
