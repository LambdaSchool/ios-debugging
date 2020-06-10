//
//  Mood.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

// Made enum conform to CaseIterable 
enum Mood: String, CaseIterable {
    case bad = "☹️"
    case neutral = "😐"
    case good = "🙂"
}
