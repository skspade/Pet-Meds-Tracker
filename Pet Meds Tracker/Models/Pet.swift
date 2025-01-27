import Foundation
import SwiftData

@Model
class Pet {
    var name: String
    var species: String
    var birthDate: Date?
    @Relationship(deleteRule: .nullify) var medications: [Medication] = []
    var uniqueIdentifier: UUID
    
    init(name: String, species: String, birthDate: Date? = nil, uniqueIdentifier: UUID = UUID()) {
        self.name = name
        self.species = species
        self.birthDate = birthDate
        self.uniqueIdentifier = uniqueIdentifier
    }
}
