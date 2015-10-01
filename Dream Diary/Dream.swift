//
//  Dream.swift
//  Dream Diary
//
//  Created by Felis Perez on 9/30/15.
//
//

import UIKit

class Dream {
    
    // MARK: Properties
    
    var dreamText: String
    
    // TODO: Add title, tags, proper nouns, date, properties.... etc.
    
    // MARK: Initialization
    
    init? (dreamText: String) {
        
        self.dreamText = dreamText
        
        if dreamText.isEmpty {
            return nil
        }
    }
    
}
