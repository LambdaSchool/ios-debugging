//
//  EntryRepresentation.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct EntryRepresentation: Decodable {
    var title: String?
    var bodyText: String?
    var mood: String?
    var timestamp: Date?
    var identifier: String?
    
    enum EntryKeys: String, CodingKey {
        case title, bodyText, mood, timestamp, identifier
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EntryKeys.self)
        
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        let bodyText = try container.decodeIfPresent(String.self, forKey: .bodyText)
        let mood = try container.decodeIfPresent(String.self, forKey: .mood)
        let timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
        
        let identifierNumber = try container.decodeIfPresent(Float.self, forKey: .identifier)
        
        if let idNumber = identifierNumber {
            let identifier = String(idNumber)
            self.identifier = identifier
        }
        
        self.title = title
        self.bodyText = bodyText
        self.mood = mood
        self.timestamp = timestamp
    }
}

func ==(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return rhs.title == lhs.title &&
        rhs.bodyText == lhs.bodyText &&
        rhs.mood == lhs.mood &&
        rhs.identifier == lhs.identifier
}

func ==(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs == lhs
}

func !=(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return !(lhs == rhs)
}

func !=(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs != lhs
}
