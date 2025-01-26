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
}
