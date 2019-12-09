#  Bugs

- [ ] initial view controller title says 'Journal - Day 4'; unsure of correct value
- [ ] not fetching entries from server
- [x] app crashes when existing entry cell is tapped
    - attempted to update views before view was loaded
- [x] edited journal data is not saved when 'save' tapped
    - entryController was not passed in segue from tableVC to detailVC
- [x] Not sending to firebase
    - was appending "json" to url rather than ".json"
