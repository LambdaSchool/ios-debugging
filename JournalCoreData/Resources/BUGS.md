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
- [ ] error decoding JSON upon being fetched from server 
