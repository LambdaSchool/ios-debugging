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
}

func ==(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return lhs == rhs.representation
}

func ==(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs == lhs.representation
}

func !=(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return !(lhs == rhs.representation)
}

func !=(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs != lhs.representation
}
