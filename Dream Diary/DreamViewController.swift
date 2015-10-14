//
//  DreamViewController.swift
//  Dream Diary
//
//  Created by Andrew Scott on 9/17/15.
//
//

import UIKit

class DreamViewController: UIViewController, UITextViewDelegate {
    
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
            let dreamText = textBox.text ?? ""
//            let dreamTitle = ""
//            let nightmareBool = true
            
//            dream = Dream(dreamText: dreamText, dreamTitle: dreamTitle, nightmareBool: nightmareBool)
            dream = Dream(dreamText: dreamText)
        }
    }
    
    
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Constructed by adding a new dream.
    var dream: Dream?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        textBox.delegate = self
        
        // Set up views if editing an existing dream.
        if let dream = dream {
            textBox.text = dream.dreamText

        }
        
        //        checkValidDream()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        
        textView.resignFirstResponder()
        
        return true
    }
    
    // MARK: Actions
    
    // MARK: UITextFieldDelegate
    
    func textViewDidEndEditing(textView: UITextView) {
        
//        checkValidDream()
        
        navigationItem.title = textBox.text
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



