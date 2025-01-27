import SwiftData

@Model
class MedicationStore {
    var medications: [Medication]
    
    init(medications: [Medication] = []) {
        self.medications = medications
    }
    
    func addMedication(_ medication: Medication) {
        medications.append(medication)
    }
    
    func getAllMedications() -> [Medication] {
        return medications
    }
    
    func medicationExists(_ medication: Medication) -> Bool {
        return medications.contains { $0.name == medication.name && $0.dosageAmount == medication.dosageAmount && $0.dosageUnit == medication.dosageUnit }
    }
}
