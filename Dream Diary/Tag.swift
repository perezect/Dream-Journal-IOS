//
//  Tag.swift
//  Dream Diary
//
//  Created by Andrew Scott on 11/3/15.
//
//

import Foundation

class Tag: NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var selected: Bool
    
    // MARK: Initialization
    init? (name: String) {
        self.name = name
        self.selected = false
        
        super.init()
        if name.isEmpty {
            return nil
        }
    }
    
    init? (name: String, selected: Bool) {
        self.name = name
        self.selected = selected
        
        super.init()
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    struct PropertyKey {
        
        static let nameKey = "name"
        static let selectedKey = "slected"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(selected, forKey: PropertyKey.selectedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let selected = aDecoder.decodeObjectForKey(PropertyKey.selectedKey) as! Bool
        
        // Must call designated initializer.
        self.init(name: name, selected: selected)
    }
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tags")
}