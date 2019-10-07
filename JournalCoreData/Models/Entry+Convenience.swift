//
//  Entry+Convenience.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    @discardableResult convenience init(title: String,
                     bodyText: String,
                     timeStamp: Date = Date(),
                     mood: String,
                     identifier: String = UUID().uuidString,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.title = title
        self.bodyText = bodyText
        self.mood = mood
        self.timeStamp = timeStamp
        self.identifier = identifier
    }
    
    @discardableResult convenience init?(entryRepresentation: EntryRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let title = entryRepresentation.title,
            let bodyText = entryRepresentation.bodyText,
            let mood = entryRepresentation.mood,
            let timeStamp = entryRepresentation.timeStamp,
            let identifier = entryRepresentation.identifier else { return nil }
        
        self.init(title: title, bodyText: bodyText, timeStamp: timeStamp, mood: mood, identifier: identifier, context: context)
    }
    
    var entryRepresentation: EntryRepresentation {
        return EntryRepresentation(title: title, bodyText: bodyText, mood: mood, timeStamp: timeStamp, identifier: identifier)
    }
}
