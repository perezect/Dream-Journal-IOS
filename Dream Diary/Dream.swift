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
        aCoder.encodeObject(dreamTitle, forKey: PropertyKey.dreamTitleKey)
        aCoder.encodeObject(alternateEnding, forKey: PropertyKey.alternateEndingKey)
        aCoder.encodeObject(isNightmare, forKey: PropertyKey.nightmareBoolKey)
        aCoder.encodeObject(isRepeat, forKey: PropertyKey.repeatBoolKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(tags, forKey: PropertyKey.tagKey)
        aCoder.encodeObject(answer1, forKey: PropertyKey.answer1Key)
        aCoder.encodeObject(answer2, forKey: PropertyKey.answer2Key)
        aCoder.encodeObject(answer3, forKey: PropertyKey.answer3Key)
        aCoder.encodeObject(properNouns, forKey: PropertyKey.properNounKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let dreamText = aDecoder.decodeObjectForKey(PropertyKey.dreamTextKey) as! String
        let dreamTitle = aDecoder.decodeObjectForKey(PropertyKey.dreamTitleKey) as! String
        let alternateEnding = aDecoder.decodeObjectForKey(PropertyKey.alternateEndingKey) as! String
        let isNightmare = aDecoder.decodeObjectForKey(PropertyKey.nightmareBoolKey) as! Bool
        let isRepeat = aDecoder.decodeObjectForKey(PropertyKey.repeatBoolKey) as! Bool
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let tags = aDecoder.decodeObjectForKey(PropertyKey.tagKey) as! [Tag]
        let answer1 = aDecoder.decodeObjectForKey(PropertyKey.answer1Key) as! String
        let answer2 = aDecoder.decodeObjectForKey(PropertyKey.answer2Key) as! String
        let answer3 = aDecoder.decodeObjectForKey(PropertyKey.answer3Key) as! String
        let properNouns = aDecoder.decodeObjectForKey(PropertyKey.properNounKey) as! [Tag]
        
        // Must call designated initializer.
        //self.init(dreamText: dreamText)
        self.init(dreamText: dreamText, dreamTitle: dreamTitle, alternateEnding: alternateEnding, isNightmare: isNightmare, isRepeat: isRepeat, date: date, tags: tags, answer1: answer1, answer2: answer2, answer3: answer3, properNouns: properNouns)
    }
    
    
    
    // MARK: Properties
    
    var dreamText: String
    var dreamTitle: String
    var alternateEnding: String
    var isNightmare: Bool
    var isRepeat: Bool
    var date: NSDate
    var tags: [Tag]
    var answer1: String
    var answer2: String
    var answer3: String
    var properNouns: [Tag]
    
    struct PropertyKey {
        
        static let dreamTextKey = "dreamText"
        static let dreamTitleKey = "dreamTitle"
        static let alternateEndingKey = "alternateEnding"
        static let nightmareBoolKey = "nightmareBool"
        static let repeatBoolKey = "repeatBool"
        static let dateKey = "dateKey"
        static let tagKey = "tagKey"
        static let answer1Key = "answer1"
        static let answer2Key = "answer2"
        static let answer3Key = "answer3"
        static let properNounKey = "properNouns"
    }
    
    // TODO: Add title, tags, proper nouns, date, properties.... etc.
    
    // MARK: Initialization
    
    init? (dreamText: String) {
        self.dreamText = dreamText
        self.dreamTitle = ""
        self.alternateEnding = ""
        self.isNightmare = false
        self.isRepeat = false
        self.date = NSDate()
        self.tags = [Tag]()
        self.answer1 = ""
        self.answer2 = ""
        self.answer3 = ""
        self.properNouns = [Tag]()
        
        super.init()
        
        if dreamText.isEmpty {
            return nil
        }
    }
    init? (dreamText: String, dreamTitle: String, alternateEnding: String, isNightmare: Bool, isRepeat: Bool, date: NSDate, tags: [Tag], answer1: String, answer2: String, answer3: String, properNouns: [Tag]) {
        
        self.dreamText = dreamText
        self.dreamTitle = dreamTitle
        self.alternateEnding = alternateEnding
        self.isNightmare = isNightmare
        self.isRepeat = isRepeat
        self.date = date
        self.tags = tags
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.properNouns = properNouns
        
        super.init()
        
        if dreamText.isEmpty {
            return nil
        }
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("dreams")
    
}
