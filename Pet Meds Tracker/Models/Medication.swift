import Foundation
import SwiftData

@Model
class Medication {
    var name: String
    var dosage: String
    var schedule: [Date]
    var notes: String?
    @Relationship(deleteRule: .cascade) var pets: [Pet]
    @Relationship(deleteRule: .cascade) var history: [MedicationHistory] = []
    
    init(name: String, dosage: String, schedule: [Date], notes: String? = nil) {
        self.name = name
        self.dosage = dosage
        self.schedule = schedule
        self.notes = notes
        self.pets = []
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
