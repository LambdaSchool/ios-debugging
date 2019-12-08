//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    
    var entryController: EntryController?
    var entry: Entry? {
        didSet {
//            updateViews()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func saveEntry(_ sender: Any) {
    
        
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text else { return }
        
        var mood: String!
        
        switch moodSegmentedControl.selectedSegmentIndex {
        case 0:
            mood = Mood.bad.rawValue
        case 1:
            mood = Mood.neutral.rawValue
        case 2:
            mood = Mood.good.rawValue
        default:
            break
        }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: bodyText, mood: mood)
        } else {
            entryController?.createEntry(with: title, bodyText: bodyText, mood: mood)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func updateViews() {
        guard let entry = entry else {
                title = "Create Entry"
                return
        }

        title = entry.title
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
        
        var segmentIndex = 0
        
        switch entry.mood {
        case Mood.bad.rawValue:
            segmentIndex = 0
        case Mood.neutral.rawValue:
            segmentIndex = 1
        case Mood.good.rawValue:
            segmentIndex = 2
        default:
            break
        }
        
        moodSegmentedControl.selectedSegmentIndex = segmentIndex
    }
    

}
