import Foundation
import SwiftData

@Model
class Pet {
    var name: String
    var species: String
    var birthDate: Date?
    @Relationship(deleteRule: .cascade) var medications: [Medication] = []
    
    init(name: String, species: String, birthDate: Date? = nil) {
        self.name = name
        self.species = species
        self.birthDate = birthDate
    }
}
