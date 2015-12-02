//
//  QuestionViewController.swift
//  Dream Diary
//
//  Created by Andrew Scott on 11/5/15.
//
//

import UIKit

class QuestionViewController: UIViewController, UITextViewDelegate {

    // MARK: Properties
    var answers: [String] = ["", "", ""]
    var kbHeight: CGFloat!              // keeps track of keyboard height
    var keyboardMoveHeight: CGFloat!    // keeps track of how far we need to move the view
    @IBOutlet weak var question1AnswerBox: UITextView!
    @IBOutlet weak var question2AnswerBox: UITextView!
    @IBOutlet weak var question3AnswerBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(answers)

        question1AnswerBox.delegate = self
        question2AnswerBox.delegate = self
        question3AnswerBox.delegate = self
        
        question1AnswerBox.text = answers[0]
        question2AnswerBox.text = answers[1]
        question3AnswerBox.text = answers[2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    // hitting the enter button in the dream text textView will get rid of the keyboard
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        // calculate the amount to move the view by so the keyboard doesn't cover the textView
        let txtY = textView.frame.origin.y
        let textH = textView.frame.height
        let sprY = textView.superview!.frame.origin.y
        let totalH = self.view.frame.height
        keyboardMoveHeight = txtY + textH + kbHeight + sprY - totalH
        if textView != question1AnswerBox {
            self.animateTextField(true)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView != question1AnswerBox {
            self.animateTextField(false)
        }
        answers[0] = question1AnswerBox.text
        answers[1] = question2AnswerBox.text
        answers[2] = question3AnswerBox.text
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        answers = [question1AnswerBox.text, question2AnswerBox.text, question3AnswerBox.text]
        print("in question page", answers[0])
        let dreamVC = segue.destinationViewController as! DreamViewController
        dreamVC.answers = answers
    }
    

}
