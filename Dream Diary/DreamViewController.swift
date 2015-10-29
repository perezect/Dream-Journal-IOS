//
//  DreamViewController.swift
//  Dream Diary
//
//  Created by Andrew Scott on 9/17/15.
//
//

import UIKit

class DreamViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        let isPresentingInAddDreamMode = presentingViewController is UINavigationController
        
        // Dismiss scene without saving anything
        if isPresentingInAddDreamMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if saveButton === sender {
            let dreamText = dreamTextBox.text ?? ""
            let dreamTitle = dreamTitleBox.text ?? ""
            let isNightmare = nightmareSwitch.on
            let isRepeat = repeatSwitch.on
            
            dream = Dream(dreamText: dreamText, dreamTitle: dreamTitle, isNightmare: isNightmare, isRepeat: isRepeat, date: NSDate())
            print (dream?.dreamTitle, dream?.dreamText)
            /*if isNewDream {
                //dream = Dream(dreamText: dreamText)
                let infoVC = segue.destinationViewController as! DreamInfoViewController
                infoVC.dream = dream
            }
            else {
                let infoVC = segue.destinationViewController as! DreamInfoViewController
                infoVC.dreamText = dreamText
            }*/
            //let infoVC = segue.destinationViewController as! DreamInfoViewController
            //infoVC.dreamText = dreamText
            //infoVC.dream = dream
        }
    }
    
    @IBAction func unwindToDreamView(sender: UIStoryboardSegue) {
        if let _ = sender.sourceViewController as? TagTableViewController {
            // Add a new meal.
            print("2")
        }
    }
    
    

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dreamTitleBox: UITextField!
    @IBOutlet weak var nightmareSwitch: UISwitch!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var dreamTextBox: UITextView!
    
    // Constructed by adding a new dream.
    var dream: Dream?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        dreamTextBox.delegate = self
        dreamTitleBox.delegate = self
        
        // Set up views if editing an existing dream.
        if let dream = dream {
            dreamTitleBox.text = dream.dreamTitle
            nightmareSwitch.on = dream.isNightmare
            repeatSwitch.on = dream.isRepeat
            dreamTextBox.text = dream.dreamText
        }
        
        //        checkValidDream()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dreamTitleBox.resignFirstResponder()
        return true
    }
    
    func scrollRangeToVisible(range: NSRange)
    {
        
    }
    
    // MARK: Actions
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    // purpose of this function is so that hitting the enter button in the dream text textView
    // will get rid of the keyboard
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool
    {
        if text == "\n" {
            dreamTextBox.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
//        checkValidDream()
        
        //navigationItem.title = textBox.text
    }
    
//    func textViewDidBeginEditing(textView: UITextView) {
//        
//        // To disable the save button while editing
//        saveButton.enabled = false
//    }
//    
//    func checkValidDream() {
//        
//        // To disable the save button when the text field is empty
//        let text = textBox.text ?? ""
//        
//        saveButton.enabled = !text.isEmpty
//    }

}



