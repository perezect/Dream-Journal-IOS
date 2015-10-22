//
//  DreamInfoViewController.swift
//  Dream Diary
//
//  Created by Andrew Scott on 10/20/15.
//
//

import UIKit

class DreamInfoViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    var dream: Dream?
    var dreamText: String?
    //var dreamTitle: String?
    
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var nightmareSwitch: UISwitch!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextBox.delegate = self
        
        // Set up views if editing an existing dream.
        if let dream = dream {
            titleTextBox.text = dream.dreamTitle
            nightmareSwitch.on = dream.isNightmare
            repeatSwitch.on = dream.isRepeat
        }
        else {
            dream = Dream(dreamText: dreamText!)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //dreamTitle = textField.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            dream!.dreamText = dreamText!
            dream!.dreamTitle = titleTextBox.text ?? ""
            dream!.isNightmare = nightmareSwitch.on
            dream!.isRepeat = repeatSwitch.on
            dream!.date = NSDate()
        }
    }
    

}
