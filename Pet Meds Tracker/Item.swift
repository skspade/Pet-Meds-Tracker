//
//  Item.swift
//  Pet Meds Tracker
//
//  Created by Sean Spade on 1/22/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
