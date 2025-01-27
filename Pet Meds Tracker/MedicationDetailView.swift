import SwiftUI

struct MedicationDetailView: View {
    @Bindable var medication: Medication
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        List {
            Section(header: Text("Medication Details")) {
                Text("Name: \(medication.name)")
                Text("Dosage: \(medication.dosageAmount) \(medication.dosageUnit.rawValue)")
                Text("Schedule: \(medication.schedule.map { dateFormatter.string(from: $0) }.joined(separator: ", "))")
            }
        }
        .navigationTitle("Medication Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Delete") {
                    deleteMedication()
                }
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    private func deleteMedication() {
        withAnimation {
            modelContext.delete(medication)
            try? modelContext.save()
        }
    }
}

#Preview {
    MedicationDetailView(medication: Medication(name: "Sample Med", dosageAmount: 10, dosageUnit: .mg, schedule: [Date()]))
}
