//
//  Dream.swift
//  Dream Diary
//
//  Created by Felis Perez on 9/30/15.
//
//

import UIKit

class Dream: NSObject, NSCoding {
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(dreamText, forKey: PropertyKey.dreamTextKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let dreamText = aDecoder.decodeObjectForKey(PropertyKey.dreamTextKey) as! String
        
        // Must call designated initializer.
        self.init(dreamText: dreamText)
    }
    
    
    
    // MARK: Properties
    
    var dreamText: String
    
    struct PropertyKey {
        static let dreamTextKey = "dreamText"
    }
    
    // TODO: Add title, tags, proper nouns, date, properties.... etc.
    
    // MARK: Initialization
    
    init? (dreamText: String) {
        
        self.dreamText = dreamText
        
        super.init()
        
        if dreamText.isEmpty {
            return nil
        }
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("dreams")
    
}
