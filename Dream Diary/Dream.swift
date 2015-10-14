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
//        aCoder.encodeObject(dreamTitle, forKey: PropertyKey.dreamTitleKey)
//        aCoder.encodeObject(nightmareBool, forKey: PropertyKey.nightmareBoolKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let dreamText = aDecoder.decodeObjectForKey(PropertyKey.dreamTextKey) as! String
//        let dreamTitle = aDecoder.decodeObjectForKey(PropertyKey.dreamTitleKey) as! String
//        let nightmareBool = aDecoder.decodeObjectForKey(PropertyKey.nightmareBoolKey) as! Bool
        
        // Must call designated initializer.
        self.init(dreamText: dreamText)
//        self.init(dreamText: dreamText, dreamTitle: dreamTitle, nightmareBool: nightmareBool)
    }
    
    
    
    // MARK: Properties
    
    var dreamText: String
  
//    var dreamTitle: String
    
//    var nightmareBool: Bool
    
    struct PropertyKey {
        
        static let dreamTextKey = "dreamText"
//        static let dreamTitleKey = "dreamTitle"
//        static let nightmareBoolKey = "nightmareBool"
    }
    
    // TODO: Add title, tags, proper nouns, date, properties.... etc.
    
    // MARK: Initialization
    
    init? (dreamText: String) {
//    init? (dreamText: String, dreamTitle: String, nightmareBool: Bool) {
        
        self.dreamText = dreamText
//        self.dreamTitle = dreamTitle
//        self.nightmareBool = nightmareBool
        
        super.init()
        
        if dreamText.isEmpty {
            return nil
        }
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("dreams")
    
}
