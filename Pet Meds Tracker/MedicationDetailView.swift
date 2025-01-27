import SwiftUI

struct MedicationDetailView: View {
    @Bindable var medication: Medication

    var body: some View {
        List {
            Section(header: Text("Medication Details")) {
                Text("Name: \(medication.name)")
                Text("Dosage: \(medication.dosage)")
                Text("Schedule: \(medication.schedule.map { dateFormatter.string(from: $0) }.joined(separator: ", "))")
            }
        }
        .navigationTitle("Medication Details")
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    MedicationDetailView(medication: Medication(name: "Sample Med", dosage: "10mg", schedule: [Date()]))
}
