import SwiftUI

struct MedicationRow: View {
    let medication: Medication
    
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        let formatter = dateFormatter()
        
        VStack(alignment: .leading) {
            Text(medication.name)
            Text("Dosage: \(medication.dosageAmount) \(medication.dosageUnit.rawValue)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(medication.schedule.map{ formatter.string(from: $0)}.joined(separator: ", "))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
