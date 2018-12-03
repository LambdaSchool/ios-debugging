//
//  EntryRepresentation.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct EntryRepresentation: Codable, Equatable {
    var title: String?
    var bodyText: String?
    var mood: String?
    var timestamp: Date?
    var identifier: String?
    
    init(title: String, bodyText: String?, mood: String, timestamp: Date, identifier: String) {
        self.title = title
        self.bodyText = bodyText
        self.mood = mood
        self.timestamp = timestamp
        self.identifier = identifier
    }
}

func ==(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return rhs.title == lhs.title &&
        rhs.bodyText == lhs.bodyText &&
        rhs.mood == lhs.mood &&
        rhs.identifier == lhs.identifier &&
        rhs.timestamp == lhs.timestamp
}

func ==(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs.title == lhs.title &&
        rhs.bodyText == lhs.bodyText &&
        rhs.mood == lhs.mood &&
        rhs.identifier == lhs.identifier &&
        rhs.timestamp == lhs.timestamp
}

func !=(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return rhs != lhs
}

func !=(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs != lhs
}
