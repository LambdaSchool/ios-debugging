//
//  EntryController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import CoreData

let baseURL = URL(string: "https://ios-code-quality-debugging.firebaseio.com/")!

enum NetworkError: Error{
    case noIdentifier
    case otherError
    case noData
    case noDecode
    case noEncode
    case noRep
}

final class EntryController {
    
    // Added a completion handler to help make more sense of the network requests
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void

    
    func createEntry(with title: String, bodyText: String, mood: String) {
        
        let entry = Entry(title: title, bodyText: bodyText, mood: mood)
        
        put(entry: entry)
        
        saveToPersistentStore()
    }
    
    func update(entry: Entry, title: String, bodyText: String, mood: String) {
        
        entry.title = title
        entry.bodyText = bodyText
        entry.timestamp = Date()
        entry.mood = mood
        
        put(entry: entry)
        
        saveToPersistentStore()
    }
    
    func delete(entry: Entry) {
        
        CoreDataStack.shared.mainContext.delete(entry)
        deleteEntryFromServer(entry: entry)
        saveToPersistentStore()
    }
    
    // Re wrote a lot of this function to make more sense
    private func put(entry: Entry, completion: @escaping CompletionHandler = { _ in }) {
        
        guard let uuid = entry.identifier else {
            completion(.failure(.noIdentifier))
            return
        }
        // Had to be changed to "appendingPathExtension" for "json"
        let requestURL = baseURL.appendingPathComponent(uuid).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            // We need to turn the entry in to an entry representation
            guard let representation = entry.entryRepresentation else {
                completion(.failure(.noRep))
                return
            }
            // Encoding the Representation
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            NSLog("Error encoding Entry: \(error)")
            completion(.failure(.noEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error{
                completion(.failure(.otherError))
                print("Error PUTting entry to server: \(error)")
            }
            completion(.success(true))
        }.resume()
    }
    
    func deleteEntryFromServer(entry: Entry, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        guard let identifier = entry.identifier else {
            NSLog("Entry identifier is nil")
            completion(NSError())
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error deleting entry from server: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func fetchEntriesFromServer(completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching entries from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }

            let moc = CoreDataStack.shared.mainContext
            
            do {
                let entryReps = try JSONDecoder().decode([String: EntryRepresentation].self, from: data).map({$0.value})
                self.updateEntries(with: entryReps, in: moc)
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(error)
                return
            }
            
            moc.perform {
                do {
                    try moc.save()
                    completion(nil)
                } catch {
                    NSLog("Error saving context: \(error)")
                    completion(error)
                }
            }
        }.resume()
    }
    
    private func fetchSingleEntryFromPersistentStore(with identifier: String?, in context: NSManagedObjectContext) -> Entry? {
        
        guard let identifier = identifier else { return nil }
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identfier == %@", identifier)
        
        var result: Entry? = nil
        do {
            result = try context.fetch(fetchRequest).first
        } catch {
            NSLog("Error fetching single entry: \(error)")
        }
        return result
    }
    
    private func updateEntries(with representations: [EntryRepresentation], in context: NSManagedObjectContext) {
        context.performAndWait {
            for entryRep in representations {
                guard let identifier = entryRep.identifier else { continue }
                
                let entry = self.fetchSingleEntryFromPersistentStore(with: identifier, in: context)
                if let entry = entry, entry != entryRep {
                    self.update(entry: entry, with: entryRep)
                } else if entry == nil {
                    _ = Entry(entryRepresentation: entryRep, context: context)
                }
            }
        }
    }
    
    private func update(entry: Entry, with entryRep: EntryRepresentation) {
        entry.title = entryRep.title
        entry.bodyText = entryRep.bodyText
        entry.mood = entryRep.mood
        entry.timestamp = entryRep.timestamp
        entry.identifier = entryRep.identifier
    }
    
    func saveToPersistentStore() {        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
