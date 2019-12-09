#  Bugs

- [ ] initial view controller title says 'Journal - Day 4'; unsure of correct value
- [x] not fetching entries from server
    - fetch method was never called; now called in tableVC.viewWillAppear
- [x] app crashes when existing entry cell is tapped
    - attempted to update views before view was loaded
- [x] edited journal data is not saved when 'save' tapped
    - entryController was not passed in segue from tableVC to detailVC
- [x] Not sending to firebase
    - was appending "json" to url rather than ".json"
- [x] error decoding JSON upon being fetched from server 
    -  Error fetching entries: typeMismatch(Swift.String, Swift.DecodingError.Context(codingPath: [_JSONKey(stringValue: "E6933CFB-E6D7-44CA-85CC-DC748E711594", intValue: nil), CodingKeys(stringValue: "identifier", intValue: nil)], debugDescription: "Expected to decode String but found a number instead.", underlyingError: nil))
    - identifier somehow given timestamp value
    - Entry+Codable.swift mistakenly set identifier to timestamp
    - Entry representations weren't being used for decoding; needed to conform EntryReps to Codable and make a new initializer
- [ ] Crash related to entryController.fetchSingleEntryFromPersistentStore
- [x] Updating from entryReps weren't saving to CoreData ('save' not called)
