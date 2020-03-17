//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // Change view didload to view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    @IBAction func saveEntry(_ sender: UIBarButtonItem) {
        
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
                self.entryController?.createEntry(with: title, bodyText: bodyText, mood: mood)
            }
         
        }
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    var entry: Entry?  // Remove didSet to avoid crash

    
    
    var entryController: EntryController?
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var bodyTextView: UITextView!

}
