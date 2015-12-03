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
        aCoder.encodeObject(answers, forKey: PropertyKey.answerKey)
        aCoder.encodeObject(properNouns, forKey: PropertyKey.properNounKey)
        aCoder.encodeObject(drawing, forKey: PropertyKey.drawingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let dreamText = aDecoder.decodeObjectForKey(PropertyKey.dreamTextKey) as! String
        let dreamTitle = aDecoder.decodeObjectForKey(PropertyKey.dreamTitleKey) as! String
        let alternateEnding = aDecoder.decodeObjectForKey(PropertyKey.alternateEndingKey) as! String
        let isNightmare = aDecoder.decodeObjectForKey(PropertyKey.nightmareBoolKey) as! Bool
        let isRepeat = aDecoder.decodeObjectForKey(PropertyKey.repeatBoolKey) as! Bool
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let tags = aDecoder.decodeObjectForKey(PropertyKey.tagKey) as! [Tag]
        let answers = aDecoder.decodeObjectForKey(PropertyKey.answerKey) as! [String]
        let properNouns = aDecoder.decodeObjectForKey(PropertyKey.properNounKey) as! [Tag]
        let drawing = aDecoder.decodeObjectForKey(PropertyKey.drawingKey) as! UIImage
        
        // Must call designated initializer.
        //self.init(dreamText: dreamText)
        self.init(dreamText: dreamText, dreamTitle: dreamTitle, alternateEnding: alternateEnding, isNightmare: isNightmare, isRepeat: isRepeat, date: date, tags: tags, answers: answers, properNouns: properNouns, drawing: drawing)
    }
    
    
    
    // MARK: Properties
    
    var dreamText: String
    var dreamTitle: String
    var alternateEnding: String
    var isNightmare: Bool
    var isRepeat: Bool
    var date: NSDate
    var tags: [Tag]
    var answers: [String]
    var properNouns: [Tag]
    var drawing: UIImage
    
    struct PropertyKey {
        
        static let dreamTextKey = "dreamText"
        static let dreamTitleKey = "dreamTitle"
        static let alternateEndingKey = "alternateEnding"
        static let nightmareBoolKey = "nightmareBool"
        static let repeatBoolKey = "repeatBool"
        static let dateKey = "dateKey"
        static let tagKey = "tagKey"
        static let answerKey = "answer"
        static let properNounKey = "properNouns"
        static let drawingKey = "drawingKey"
    }
        
    // MARK: Initialization
    
    init? (dreamText: String) {
        self.dreamText = dreamText
        self.dreamTitle = ""
        self.alternateEnding = ""
        self.isNightmare = false
        self.isRepeat = false
        self.date = NSDate()
        self.tags = [Tag]()
        self.answers = ["", "", ""]
        self.properNouns = [Tag]()
        self.drawing = UIImage()
        
        super.init()
        
        if dreamText.isEmpty {
            return nil
        }
    }
    init? (dreamText: String, dreamTitle: String, alternateEnding: String, isNightmare: Bool, isRepeat: Bool, date: NSDate, tags: [Tag], answers: [String], properNouns: [Tag], drawing: UIImage) {
        
        self.dreamText = dreamText
        self.dreamTitle = dreamTitle
        self.alternateEnding = alternateEnding
        self.isNightmare = isNightmare
        self.isRepeat = isRepeat
        self.date = date
        self.tags = tags
        self.answers = answers
        self.properNouns = properNouns
        self.drawing = drawing
        
        super.init()
        
        if dreamText.isEmpty {
            return nil
        }
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("dreams")
    
}
