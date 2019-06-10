# Bugs

## Bug 1:
### Problem 
App crashes when going into the detail view of a previously created entry.

 *__Error Code:__*
```
Fatal error: Unexpectedly found nil 
while implicitly unwrapping an 
Optional value
2019-06-10 11:58:02.617857-0700
JournalCoreData[3982:103323]
Fatal error: Unexpectedly found nil
while implicitly unwrapping an 
Optional value
```

### Solution:
The updateViews function in the EntryDetailsViewContoller is trying to use the IBOutlet properties before the view is finished loading and therefore only able to access a nil. I added a isViewLoaded check to the guard statement on line 44.

## Bug 2:
### Problem 
App is not downloading from external database.

### Step 1:

 *__Error Code:__*
```
N/A
```

### Solution:
fetchEntriesFromServer() Function was not being called. I set up initializer for the EntryController class and called the function from there.

### Step 2:

*__Error Code__*
```
2019-06-10 12:59:40.109197-0700
JournalCoreData[5267:142335] ***
Terminating app due to uncaught 
exception 
'NSInvalidArgumentException', 
reason: 'keypath identfier not found 
in entity <NSSQLEntity Entry id=1>'

```

### Solution
The fetchSingleEntryFromPersistentStore() makes a NSPredicate call. The format string had a spelling error.

## Bug 3:

### Problem
App is not pushing data to the remote database.

*__Error Code__*
```
N/A
```

### Solution
The put() function inside of EntryConroller was addinf 'json' as a path component instead of as a path extension. I fixed that and now it pushes to the database.

## Bug 4:

### Problem
App won't pull from server again.

*__Error Code__*
```
2019-06-10 13:43:11.252920-0700
JournalCoreData[5973:168191] 
Error decoding JSON data:
typeMismatch(Swift.String,
Swift.DecodingError.
Context(codingPath: [_JSONKey(stringValue: 
"796B8CE4-4836-4A2C-AF06-AA3B53267B2A", 
intValue: nil), 
CodingKeys(stringValue: "identifier", 
intValue: nil)], 
debugDescription: "Expected to decode String 
but found a number instead.", 
underlyingError: nil))
```

### Solution
The entry information was being encoded wrong, so when the journal tried to redownload that data the was a decoding error. The timestamp information was being placed inside of the identifier key. I fixed it by going into Entry+Codable and changing line 20 from 
```
try container.encode(timestamp, forKey: .identifier)
```
to
```
try container.encode(identifier, forKey: .identifier)
```

## Bug 5:

### Problem
The app does not update settings from the detail view. 

*__Error Code__*
```
N/A
```

### Solution
The table view was not passing an instance of EntryController to the DetailView when a entry was being editited. To fix I add
```
destinationVC.entryController = entryController
```
to line 119 of EntryTableViewController

## Bug 6:
The app does not sort entries according to mood

*__Error Code__*
```
N/A
```

### Solution
The main sort descriptor must be related to the fetch controller section name key. In this case the key was set  to mood and the sort eas set to timestamp. To fix it I cahnged Line  119 from 
```
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
```
to
```
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mood", ascending: false), NSSortDescriptor(key: "timestamp", ascending: false)]
```