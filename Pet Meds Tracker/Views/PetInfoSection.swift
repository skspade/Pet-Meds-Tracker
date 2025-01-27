import SwiftUI

struct PetInfoSection: View {
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
