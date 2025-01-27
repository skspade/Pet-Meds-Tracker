import SwiftUI

struct MedicationRow: View {
    let medication: Medication
    
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var body: some View {
        let formatter = dateFormatter()
        
        VStack(alignment: .leading) {
            Text(medication.name)
            Text("Dosage: \(medication.dosage)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(medication.schedule.map{ formatter.string(from: $0)}.joined(separator: ", "))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
