//
//  ContentView.swift
//  Pet Meds Tracker
//
//  Created by Sean Spade on 1/22/25.
//

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
        .modelContainer(for: Pet.self, inMemory: true)
}
