import Foundation
import SwiftData

@Model
class Medication {
    var name: String
    var dosageAmount: Double
    var dosageUnit: DosageUnit
    var schedule: [Date]
    var notes: String?
    @Relationship(deleteRule: .cascade) var pets: [Pet]
    @Relationship(deleteRule: .cascade) var history: [MedicationHistory] = []
    var uniqueIdentifier: UUID
    
    init(name: String, dosageAmount: Double, dosageUnit: DosageUnit, schedule: [Date], notes: String? = nil, uniqueIdentifier: UUID = UUID()) {
        self.name = name
        self.dosageAmount = dosageAmount
        self.dosageUnit = dosageUnit
        self.schedule = schedule
        self.notes = notes
        self.pets = []
        self.uniqueIdentifier = uniqueIdentifier
    }
    
    func addPet(_ pet: Pet) {
        pets.append(pet)
        pet.medications.append(self)
    }
}

@Model
class MedicationHistory {
    var givenAt: Date
    var dosage: String
    var notes: String?
    
    init(givenAt: Date, dosage: String, notes: String? = nil) {
        self.givenAt = givenAt
        self.dosage = dosage
        self.notes = notes
    }
}

enum DosageUnit: String {
    case mg = "mg"
    case ml = "ml"
    case tablet = "tablet"
    case capsule = "capsule"
    case drop = "drop"
    case tsp = "tsp"
    case tbsp = "tbsp"
}
