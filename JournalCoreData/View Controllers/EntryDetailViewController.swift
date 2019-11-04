//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
		saveButtonEnable(enabled: false)
		bodyTextView.delegate = self
    }

	@IBAction func titleFieldChanged(_ sender: UITextField) {
		saveButtonEnable(enabled: true)
	}


    @IBAction func saveEntry(_ sender: Any) {
        
        guard let title = titleTextField.text,
			!title.isEmpty,
            let bodyText = bodyTextView.text else {
				let alert = UIAlertController(title: "An Entry must at least have a title", message: nil, preferredStyle: .alert)
				let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
				alert.addAction(alertAction)
				present(alert, animated: true, completion: nil)
				return
		}
        
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

    private func updateViews() {
        guard let entry = entry,
		isViewLoaded else {
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

	private func saveButtonEnable(enabled: Bool) {
		saveButton.isEnabled = enabled
	}
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	
}

extension EntryDetailViewController: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		saveButtonEnable(enabled: true)
	}
}
