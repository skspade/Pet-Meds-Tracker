import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var pets: [Pet]
    @State private var showingAddPet = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(pets) { pet in
                    NavigationLink {
                        PetDetailView(pet: pet)
                    } label: {
                        Text(pet.name)
                    }
                }
                .onDelete(perform: deletePets)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddPet = true }) {
                        Label("Add Pet", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPet) {
                AddPetView()
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width > 100 {
                            // Handle navigation back gesture
                        }
                    }
            )
        } detail: {
            Text("Select a pet")
        }
    }

    private func deletePets(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(pets[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Pet.self, Medication.self, MedicationHistory.self], configurations: ModelConfiguration(cloudKitContainer: CKContainer.default()))
}
