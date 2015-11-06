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
            // retrieve all the information the user has entered
            let dreamText = dreamTextBox.text ?? ""
            let dreamTitle = dreamTitleBox.text ?? ""
            let alternateEnding = alternateEndingTextBox.text ?? ""
            let isNightmare = nightmareSwitch.on
            let isRepeat = repeatSwitch.on
            // create a dream object with all of the user's information
            dream = Dream(dreamText: dreamText, dreamTitle: dreamTitle, alternateEnding: alternateEnding,
                isNightmare: isNightmare, isRepeat: isRepeat, date: date, tags: tags, answers: answers, properNouns: properNouns)
            print (dream?.dreamTitle, dream?.dreamText)
            saveTags()
        }
        // going to the tag page
        else if segue.identifier == "ShowTags" {
            let tagViewController = segue.destinationViewController as! TagTableViewController
            tagViewController.tags = tags
        }
        // going to the question page
        else if segue.identifier == "AnswerQuestions" {
            let navVC = segue.destinationViewController as! UINavigationController
            let questionVC = navVC.topViewController as! QuestionViewController
            questionVC.answers = answers
        }
    }

    
    // MARK: Properties

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dreamTitleBox: UITextField!
    @IBOutlet weak var nightmareSwitch: UISwitch!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var dreamTextBox: UITextView!
    @IBOutlet weak var alternateEndingTextBox: UITextView!
    var kbHeight: CGFloat!              // keeps track of keyboard height
    var keyboardMoveHeight: CGFloat!    // keeps track of how far we need to move the view
    var dream: Dream?
    var tags: [Tag] = []
    var date: NSDate = NSDate()
    var properNouns: [Tag] = []
    var answers: [String] = ["", "", ""]
    
    // Everything that happens when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegates
        dreamTextBox.delegate = self
        dreamTitleBox.delegate = self
        alternateEndingTextBox.delegate = self
        
        // default to having the nightmare and repeat switches off
        nightmareSwitch.on = false
        repeatSwitch.on = false
        
        // Set up fields if editing an existing dream.
        if let dream = dream {
            dreamTitleBox.text = dream.dreamTitle
            nightmareSwitch.on = dream.isNightmare
            repeatSwitch.on = dream.isRepeat
            dreamTextBox.text = dream.dreamText
            tags = dream.tags
            date = dream.date
            answers = dream.answers
        }
        
        // load tags if we aren't editing an existing dream
        if (tags.isEmpty) {
            if let savedTags = loadGeneralTags() {
                tags += savedTags
                for tag in tags {
                    tag.selected = false
                }
                print("loaded general tags")
            } else {
                loadSampleTags()
            }
        }
        
        addPlaceholders()
    
        // hide the new ending box if not a nightmare
        alternateEndingTextBox.hidden = !nightmareSwitch.on
        print("answers", answers[0])
    }
    
    // add placeholder text to the textview's if nothing is there
    func addPlaceholders() {
        if let dream = dream {
            if dreamTextBox.text == "Enter the dream" {
                dreamTextBox.textColor = UIColor.lightGrayColor()
            }
            alternateEndingTextBox.text = dream.alternateEnding
            if alternateEndingTextBox.text == "Enter a new ending" {
                alternateEndingTextBox.textColor = UIColor.lightGrayColor()
            }
        }
        
        // add placeholder for the dream text if nothing is there
        if dreamTextBox.text == "" {
            dreamTextBox.text = "Enter the dream"
            dreamTextBox.textColor = UIColor.lightGrayColor()
        }
        
        // add placeholder for the alternate dream ending text if nothing is there
        if alternateEndingTextBox.text == "" {
            alternateEndingTextBox.text = "Enter a new ending"
            alternateEndingTextBox.textColor = UIColor.lightGrayColor()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func saveTags() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tags, toFile: Tag.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tags...")
        }
        print("saved tags")
    }
    
    func loadGeneralTags() -> [Tag]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Tag.ArchiveURL.path!) as? [Tag]
    }
    
    func loadSampleTags () {
        let tag1 = Tag(name: "Falling")!
        
        tags += [tag1]
    }
    

    // MARK UITextFieldDelegate

    // get rid of the keyboard when the user hits enter for the dream title box
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dreamTitleBox.resignFirstResponder()
        return true
    }
    
    
    // MARK Keyboard (preventing keyboard from covering text views)
   
    // set up notifications for keyboard
   override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        print("added notification")
    }
    
    // get rid of keyboard notifications when leaving
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    // gets the height of the keyboard when it is about to show up
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                print (kbHeight)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // need if running on simulator without the iphone keyboard present
        /*if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                print (kbHeight)
            }
        }*/
    }
    
    // Moves the view up or down so that the keyboard doesn't cover a text view
    func animateTextField(up: Bool) {
        let movement = (up ? -keyboardMoveHeight : keyboardMoveHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    
    
    // MARK: Actions
    
    // updates whether the alternate ending box is shown whenever the user toggles the nightmare switch
    @IBAction func nightmareToggled(sender: UISwitch) {
        alternateEndingTextBox.hidden = !sender.on      // TODO: find way to do this that doesn't give constraint issues
    }
    
    @IBAction func unwindFromQuestionPage(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? QuestionViewController {
            answers = sourceViewController.answers
            print("answers", answers[0])
        }
    }

    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    // hitting the enter button in the dream text textView will get rid of the keyboard
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool
    {
        if text == "\n" {
            dreamTextBox.resignFirstResponder()
            alternateEndingTextBox.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        // if there is placeholder text, remove it
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        // calculate the amount to move the view by so the keyboard doesn't cover the textView
        let txtY = textView.frame.origin.y
        let textH = textView.frame.height
        let sprY = textView.superview!.frame.origin.y
        let totalH = self.view.frame.height
        keyboardMoveHeight = txtY + textH + kbHeight + sprY - totalH
        self.animateTextField(true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        // put back placeholder text if nothing is in the textView
        if textView == dreamTextBox && textView.text.isEmpty {
            textView.text = "Enter the dream"
            textView.textColor = UIColor.lightGrayColor()
        } else if textView == alternateEndingTextBox && textView.text.isEmpty {
            textView.text = "Enter a new ending"
            textView.textColor = UIColor.lightGrayColor()
        }
        self.animateTextField(false)
    }

}



